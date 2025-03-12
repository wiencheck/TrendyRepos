// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftSoup
import SplunkTestShared

public class GithubService {
    
    public static func fetchRepositoryDetails(at path: String) async throws -> GithubRepository {
        let request = try makeRepositoryRequest(path: path)
        let data = try await fetchData(for: request)
//        let url = Bundle.module.url(forResource: "example", withExtension: "json")!
//        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(GithubRepository.self, from: data)
    }
    
    public static func fetchTrendingRepositories(
        range: GithubTrendingTimeRange
    ) async throws -> [GithubRepository] {
        let request = try makeTrandingRepositoriesRequest(range: range)
        let data = try await fetchData(for: request)
        
        guard let html = String(data: data, encoding: .utf8) else {
            throw Error.parsingFailed(context: "data-encoding")
        }
        
        let doc: Document = try SwiftSoup.parse(html)
        guard let hpc = try doc.select("div[data-hpc]").first() else {
            throw Error.elementNotFound(context: "div[data-hpc]")
        }
        
        var repositories: [GithubRepository] = []
        /*
         Info about each repository is split into separate elements identified by "article" tag
         */
        var article: Element! = try hpc.select("article").first()
        while article != nil {
            try repositories.append(
                parseArticleElement(article)
            )
            article = try article.nextElementSibling()
        }
        
        return repositories
    }
    
}

public extension GithubService {
    
    enum Error: LocalizedError {
        case invalidURL
        case elementNotFound(context: String)
        case parsingFailed(context: String)
        case invalidResponse(code: Int)
        
        public var errorDescription: String? {
            switch self {
            case .invalidURL:
                "Invalid URL"
            case .elementNotFound(let context):
                "Element not found (\(context)"
            case .parsingFailed(let context):
                "Parsing failed (\(context)"
            case .invalidResponse(let code):
                "Invalid response (\(code))"
            }
        }
    }
    
}

private extension GithubService {
    
    static func makeRepositoryRequest(path: String) throws -> URLRequest {
        var components = URLComponents(string: "https://api.github.com")!
        components.path = "/repos\(path)"
        guard let url = components.url else {
            throw Error.invalidURL
        }
        var request = URLRequest(url: url)
        request.addValue(
            "application/vnd.github+json",
            forHTTPHeaderField: "accept"
        )
        
        return request
    }
    
    static func makeTrandingRepositoriesRequest(range: GithubTrendingTimeRange) throws -> URLRequest {
        var components = URLComponents(string: "https://github.com")!
        components.path = "/trending"
        components.queryItems = [
            URLQueryItem(name: "since", value: range.queryParameter)
        ]
        
        guard let url = components.url else {
            throw Error.invalidURL
        }
        return URLRequest(url: url)
    }
    
    static func fetchData(for request: URLRequest) async throws -> Data {
        let result = try await URLSession.shared.data(for: request)
        guard let response = result.1 as? HTTPURLResponse else {
            throw Error.invalidResponse(code: -1)
        }
        guard response.statusCode < 400 else {
            throw Error.invalidResponse(code: response.statusCode)
        }
        
        return result.0
    }
    
    static func parseArticleElement(_ article: Element) throws -> GithubRepository {
        assert(
            article.tagName() == "article",
            "parseArticleElement expects given element to be an 'article'"
        )
        
        /*
         Example heading: "camel-ai / camel"
         Where first half is author's name and then repo's name
         */
        let heading = try article.getElementsByClass("h3 lh-condensed")
        let titleComponents = try heading.text()
            .components(separatedBy: " / ")
        guard titleComponents.count == 2 else {
            throw Error.parsingFailed(context: "h3 lh-condensed")
        }
        
        /* Path to the repository, relative to github root address */
        let path = try article.getElementsByClass("Link")
            .attr("href")
        
        let description = try article.getElementsByClass("col-9 color-fg-muted my-1 pr-4")
            .text()
        
        /* Read stars and forks */
        let links = try article.getElementsByTag("a")
        
        var stars = 0, forks = 0
        for element in links {
            let link = try element.attr("href")
            
            if link.hasSuffix("stargazers") {
                var rawStars = try element.text()
                rawStars.unicodeScalars.removeAll {
                    !CharacterSet.decimalDigits.contains($0)
                }
                if let _stars = Int(rawStars) {
                    stars = _stars
                }
                else {
                    throw Error.parsingFailed(context: "stargazers")
                }
            }
            if link.hasSuffix("forks") {
                var rawForks = try element.text()
                rawForks.unicodeScalars.removeAll {
                    !CharacterSet.decimalDigits.contains($0)
                }
                if let _forks = Int(rawForks) {
                    forks = _forks
                }
                else {
                    throw Error.parsingFailed(context: "forks")
                }
            }
        }
        guard let repository = GithubRepository(
            name: titleComponents[1],
            ownerName: titleComponents[0],
            description: description,
            path: path,
            stars: stars,
            forks: forks
        )
        else {
            throw Error.parsingFailed(context: "repository nil")
        }
        return repository
    }
    
}
