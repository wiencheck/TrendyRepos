// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftSoup

public class GithubService {
    
    public static func fetchTrendingRepositories(
        range: GithubTrendingTimeRange
    ) async throws -> [GithubRepository] {
        let trendingPageURL = try makeTrandingRepositoriesURL(range: range)
        let html = try await fetchHTML(forURL: trendingPageURL)
        
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
    }
    
}

private extension GithubService {
    
    static func makeTrandingRepositoriesURL(range: GithubTrendingTimeRange) throws -> URL {
        var components = URLComponents(string: "https://github.com")!
        components.path = "/trending"
        components.queryItems = [
            URLQueryItem(name: "since", value: range.parameter)
        ]
        
        guard let url = components.url else {
            throw Error.invalidURL
        }
        return url
    }
    
    static func fetchHTML(forURL url: URL) async throws -> String {
        let result = try await URLSession.shared.data(from: url)
        guard let response = result.1 as? HTTPURLResponse else {
            throw Error.invalidResponse(code: -1)
        }
        guard response.statusCode < 400 else {
            throw Error.invalidResponse(code: response.statusCode)
        }
        
        return String(data: result.0, encoding: .utf8) ?? ""
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
        return GithubRepository(
            name: titleComponents[1],
            author: titleComponents[0],
            description: description,
            path: path,
            stars: stars,
            forks: forks
        )
    }
    
}
