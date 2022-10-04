import XCTest
@testable import Clarinete
import Pluma

final class ClarineteTests: XCTestCase {
    
    func testTrendingSuccess() {
        let client = MockClient(bundle: Bundle.module)
        let pluma = Pluma(client: client, decoder: Pluma.defaultDecoder())

        let clarinete = Clarinete(client: pluma)
        let trends = await clarinete.getTrends()
        XCTAssert(trends.count > 0)
    }
}
