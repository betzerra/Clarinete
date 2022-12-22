//
//  NLPHelper.swift
//  
//
//  Created by Ezequiel Becerra on 21/12/2022.
//

import Foundation
import CoreML

public class NLPHelper {
    private let tagger: NSLinguisticTagger
    private let text: String

    private let options: NSLinguisticTagger.Options = [
        .omitPunctuation,
        .omitWhitespace,
        .joinNames
    ]

    public init(text: String) {
        tagger = NSLinguisticTagger(tagSchemes:[.nameType], options: 0)
        tagger.string = text
        self.text = text
    }

    public var namedEntities: [String] {
        var entities = [String]()

        let range = NSRange(location: 0, length: text.utf16.count)

        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
        tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, stop in
            if let tag = tag, tags.contains(tag) {
                let name = (text as NSString).substring(with: tokenRange)
                entities.append(name)
            }
        }

        return entities
    }
}
