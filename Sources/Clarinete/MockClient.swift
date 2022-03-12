//
//  MockClient.swift
//  
//
//  Created by Ezequiel Becerra on 11/03/2022.
//

import Foundation

public class MockClient {
    /// Forced response data for mocking
    public var responseData: Data?
}

extension MockClient: APIClient {
    public func get<T>(
        path: String,
        completion: ((Result<T, Error>) -> Void)
    ) -> URLSessionDataTask? where T : Decodable {

        guard let data = responseData else {
            completion(.failure(APIError.noResponse))
            return nil
        }

        do {
            let resource = try Clarinete.decoder().decode(T.self, from: data)
            completion(.success(resource))
        } catch {
            completion(.failure(error))
        }
        
        return nil
    }
}
