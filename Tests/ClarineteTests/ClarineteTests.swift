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
                XCTAssertEqual(posts.count, 40)
                
                let first = posts.first!
                XCTAssertEqual(first.id, 37863081)
                XCTAssertEqual(first.name, "Rozín")
                XCTAssertEqual(first.title, "Murió Gerardo Rozín: cómo le contó a su amigo Osvaldo Bazán, con humor, que se estaba muriendo de cáncer")
                XCTAssertEqual(first.relatedTopics.count, 1)
                XCTAssert(first.relatedTopics.contains("Gerardo Rozín"))
                XCTAssertEqual(first.url, URL(string: "https://clarin.com/espectaculos/murio-gerardo-rozin-conto-humor-amigo-osvaldo-bazan-muriendo-cancer_0_O3dn0PCKx3.html")!)
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
