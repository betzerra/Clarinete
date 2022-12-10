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
}
