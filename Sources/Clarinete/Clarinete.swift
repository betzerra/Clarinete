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
        completion: @escaping ((Result<[Trend], Error>) -> Void)
    ) -> URLSessionDataTask? {

        let handler: ((Result <[Post], Error>) -> Void) = { result in
            switch result {
            case .success(let posts):
                let trends = Trend.trends(from: posts)
                completion(.success(trends))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }

        return client.get(
            path: "/api/trends",
            completion: handler
        )
    }
}
