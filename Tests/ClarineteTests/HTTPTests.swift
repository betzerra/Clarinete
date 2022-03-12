//
//  HTTPTests.swift
//  
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import XCTest
@testable import Clarinete

class HTTPTests: XCTestCase {
    func testTrendingSuccess() {
        let expectation = expectation(description: "HTTP Request finish")

        let clarinete = Clarinete(client: HTTPClient())
        _ = clarinete.getTrends { result in
            switch result {
            case .success(let trends):
                XCTAssert(trends.count > 0)

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
}
