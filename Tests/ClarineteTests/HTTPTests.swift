//
//  HTTPTests.swift
//  
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import XCTest
@testable import Clarinete

class HTTPTests: XCTestCase {
    static func configuration() -> Configuration {
        return Configuration(host: "https://clarinete.seppo.com.ar")
    }

    func testTrendingSuccess() {
        let expectation = expectation(description: "HTTP Request finish")

        let client = try! HTTPClient(configuration: HTTPTests.configuration())
        let clarinete = Clarinete(client: client)
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
