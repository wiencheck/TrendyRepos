// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftSoup

public class GithubService {
    
    public static func fetchTrendingRepositories(
        range: GithubTrendingTimeRange
    ) async throws -> [GithubRepository] {
        var repositories: [GithubRepository] = []
        
        // Define file name
        let fileName = Bundle.module.path(forResource: "trending_today", ofType: "html")!
        // Get the source as string
        let html = try String(contentsOfFile: fileName)
        // Convert source code to Document Object to manage
        let doc: Document = try SwiftSoup.parse(html)
        let hpc = try doc.select("div[data-hpc]").first()!
        
        var article: Element! = try hpc.select("article").first()
        while article != nil {
            let heading = try article.getElementsByClass("h3 lh-condensed")
            /* Example heading: "camel-ai / camel" */
            let titleComponents = try heading.text()
                .components(separatedBy: " / ")
            guard titleComponents.count == 2 else {
                continue
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
                        
                    }
                }
            }
            repositories.append(
                GithubRepository(
                    name: titleComponents[1],
                    author: titleComponents[0],
                    description: description,
                    path: path,
                    stars: stars,
                    forks: forks
                )
            )
            article = try article.nextElementSibling()
        }
        
        return repositories
    }
    
}

private extension GithubService {
    
    
    
}
