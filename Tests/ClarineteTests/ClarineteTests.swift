import XCTest
@testable import Clarinete

final class ClarineteTests: XCTestCase {
    
    func testTrendingSuccess() {
        let mockClient = MockClient()
        mockClient.responseData = try! Bundle.module.data(from: "GET_trends")
        
        let clarinete = Clarinete(client: mockClient)
        _ = clarinete.getTrends { result in
            switch result {
            case .success(let trends):
                XCTAssert(trends.count > 0)
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
