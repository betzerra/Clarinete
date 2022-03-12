import XCTest
@testable import Clarinete

final class ClarineteTests: XCTestCase {
    
    func testTrendingSuccess() {
        let mockClient = MockClient()
        mockClient.responseData = try! Bundle.module.data(from: "GET_trends")
        
        let clarinete = Clarinete(client: mockClient)
        _ = clarinete.getTrends { result in
            switch result {
            case .success(let posts):
                XCTAssertEqual(posts.count, 3)
                
                let first = posts.first!
                XCTAssertEqual(first.id, 10333)
                XCTAssertEqual(first.name, "Gabriel Boric")
                XCTAssertEqual(first.title, "Boric: “Chile defenderá los DDHH sin importar la ideología que los vulnere”")
                XCTAssertEqual(first.relatedTopics.count, 2)
                XCTAssert(first.relatedTopics.contains("Chile"))
                XCTAssert(first.relatedTopics.contains("DDHH"))
                XCTAssertEqual(first.url, URL(string: "https://clarin.com/mundo/gabriel-boric-da-primer-discurso-presidente-chile-movilizaciones-_0_OIB1zsxKeP.html")!)
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
