//
//  TrendTests.swift
//  
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import XCTest
@testable import Clarinete

class TrendTests: XCTestCase {

    func testIsRelatedTrue() throws {
        let trend = Trend(name: "Felipe Berríos")
        trend.relatedTopics = [
            "Gabriel Boric",
            "Felipe",
            "Berríos"
        ]

        let post = Post(
            id: 27242002,
            name: "Berríos",
            title: "Carlos Montes por la incorporación de Felipe Berríos (...)",
            relatedTopics: [
                "Gabriel Boric"
              ],
            url: URL(string: "https://www.foo.bar/")!
        )

        XCTAssertEqual(trend.isRelated(with: post), true)
    }
    
    func testAppendPost() throws {
        let trend = Trend(name: "Felipe Berríos")
        trend.relatedTopics = [
            "Gabriel Boric",
        ]

        let post = Post(
            id: 27242002,
            name: "Berríos",
            title: "Carlos Montes por la incorporación de Felipe Berríos (...)",
            relatedTopics: [
                "Felipe Berríos",
                "Gabriel Boric",
                "Felipe"
              ],
            url: URL(string: "https://www.foo.bar/")!
        )

        trend.append(post: post)

        XCTAssert(trend.relatedTopics.contains("Gabriel Boric"))
        XCTAssert(trend.relatedTopics.contains("Felipe Berríos"))
        XCTAssert(trend.relatedTopics.contains("Felipe"))
    }
}
