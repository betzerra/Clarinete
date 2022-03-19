//
//  APIClient.swift
//  
//
//  Created by Ezequiel Becerra on 11/03/2022.
//

import Foundation

public protocol APIClient {
    func get<T: Decodable>(
        path: String,
        completion: @escaping ((Result<T, Error>) -> Void)
    ) -> URLSessionDataTask?
}
