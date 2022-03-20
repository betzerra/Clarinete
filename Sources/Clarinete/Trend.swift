//
//  Trend.swift
//  
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import Foundation

public class Trend {
    public var name: String
    public var relatedTopics = Set<String>()
    public var posts = [Post]()

    public var summary: Summary? {
        let post = posts.first(where: { $0.summary != nil })
        return post?.summary
    }
    
    init(name: String) {
        self.name = name
    }
    
    func isRelated(with post: Post) -> Bool {
        if name == post.name {
            return true
        }
        
        var topics = post.relatedTopics
        topics.append(post.name)
        
        // true if relatedTopics has members in common with topics
        return !relatedTopics.isDisjoint(with: topics)
    }
    
    func append(post: Post) {
        if !name.contains(post.name) {
            name = "\(name), \(post.name)"
        }

        posts.append(post)
        relatedTopics.formUnion(post.relatedTopics)
    }
    
    static func trends(from posts: [Post]) -> [Trend] {
        var trends = [Trend]()
        posts.forEach { post in
            if let relatedTrend = trends.relatedTrend(with: post) {
                relatedTrend.append(post: post)
            } else {
                let newTrend = Trend(name: post.name)
                newTrend.append(post: post)
                trends.append(newTrend)
            }
        }

        return trends.filter { $0.summary != nil }
    }
}

extension Array where Element == Trend {
    func relatedTrend(with post: Post) -> Trend? {
        for trend in self {
            if trend.isRelated(with: post) {
                return trend
            }
        }
        
        return nil
    }
}
