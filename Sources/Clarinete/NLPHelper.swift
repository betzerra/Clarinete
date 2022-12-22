//
//  NLPHelper.swift
//  
//
//  Created by Ezequiel Becerra on 21/12/2022.
//

import Foundation
import NaturalLanguage

public class NLPHelper {
    private let tagger: NLTagger
    private let text: String

    private let options: NSLinguisticTagger.Options = [
        .omitPunctuation,
        .omitWhitespace,
        .joinNames
    ]

    public init(text: String) {
        tagger = NLTagger(tagSchemes: [.nameType])
        tagger.string = text
        self.text = text
    }

    public var namedEntities: [String] {
        var entities = [String]()

        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        let tags: [NLTag] = [.personalName, .placeName, .organizationName]

        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: options) { tag, tokenRange in
            // Get the most likely tag, and print it if it's a named entity.
            if let tag = tag, tags.contains(tag) {
                let name = String(text[tokenRange])
                entities.append(name)
            }
            return true
        }

        return entities
    }
}
