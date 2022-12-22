//
//  Post.swift
//  
//
//  Created by Ezequiel Becerra on 11/03/2022.
//

import Foundation

public struct Post: Codable {
    public let id: Int
    public let name: String
    public let title: String
    public let relatedTopics: [String]
    public let url: URL
    public let category: PostCategory?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let title = try container.decode(String.self, forKey: .title)
        self.title = title

        let parsedTopics = try container.decode([String].self, forKey: .relatedTopics)
        let processor = NLPHelper(text: title)

        var topics = Set<String>(parsedTopics)
        topics.formUnion(processor.namedEntities)
        self.relatedTopics = Array(topics)

        self.url = try container.decode(URL.self, forKey: .url)
        self.category = try container.decodeIfPresent(PostCategory.self, forKey: .category)
    }

    init(
        id: Int,
        name: String,
        title: String,
        relatedTopics: [String],
        url: URL,
        category: PostCategory
    ) {
        self.id = id
        self.name = name
        self.title = title
        self.relatedTopics = relatedTopics
        self.url = url
        self.category = category
    }
}
