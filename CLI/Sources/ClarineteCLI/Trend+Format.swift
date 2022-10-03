//
//  Trend+Format.swift
//  
//
//  Created by Ezequiel Becerra on 02/10/2022.
//

import Clarinete
import Foundation

extension Trend {
    var formattedRelatedTopics: String {
        relatedTopics.sorted().joined(separator: ", ")
    }
}
