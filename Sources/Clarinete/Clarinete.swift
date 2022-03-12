import Foundation

public struct Clarinete {
    let client: APIClient
    
    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public init() {
        self.init(client: HTTPClient())
    }

    public init(client: APIClient) {
        self.client = client
    }
    
    public func getTrends(
        completion: @escaping ((Result<[Post], Error>) -> Void)
    ) -> URLSessionDataTask? {
        return client.get(
            path: "/api/trends",
            completion: completion
        )
    }
}
