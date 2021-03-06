//
//  HTTPClient.swift
//  
//
//  Created by Ezequiel Becerra on 12/03/2022.
//

import Foundation

enum HTTPClientError: Error {
    case badHost
}

class HTTPClient {
    let host: String
    let scheme: String

    init(configuration: Configuration) throws {
        let components = URLComponents(string: configuration.host)
        guard
            let scheme = components?.scheme,
            let host = components?.host else {

            throw HTTPClientError.badHost
        }

        self.host = host
        self.scheme = scheme
    }
}

extension HTTPClient: APIClient {

    func get<T>(
        path: String,
        completion: @escaping ((Result<T, Error>) -> Void)
    ) -> URLSessionDataTask? where T : Decodable {

        return request(path: path, method: "GET", completion: completion)
    }

    func request<T>(
        path: String,
        method: String,
        completion: @escaping ((Result<T, Error>) -> Void)
    ) -> URLSessionDataTask? where T : Decodable {

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        guard let url = components.url else {
            completion(.failure(APIError.badURL))
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIError.noResponse))
                return
            }

            do {
                let resource = try Clarinete.decoder().decode(T.self, from: data)
                completion(.success(resource))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
        return task
    }
}
