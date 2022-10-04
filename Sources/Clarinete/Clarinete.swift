import Foundation
import Pluma

public struct Clarinete {
    let client: Pluma

    public init(configuration: Configuration) throws {
        let client = Pluma(baseURL: configuration.host, decoder: nil)
        self.init(client: client)
    }

    public init(client: Pluma) {
        self.client = client
    }

    public func getTrends() async throws -> [Trend] {
        let posts: [Post] = try await client.request(
            method: .GET,
            path: "/api/trends",
            params: nil
        )

        return Trend.trends(from: posts)
    }
}
