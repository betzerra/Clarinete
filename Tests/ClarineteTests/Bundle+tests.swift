//
//  Bundle+tests.swift
//  Clarinete
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import Foundation

extension Bundle {
    func data(from mock: String) throws -> Data {
        let url = Bundle.module.url(forResource: mock, withExtension: "json")!
        return try Data(contentsOf: url)
    }
}
