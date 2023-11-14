//
//  NetworkClient.swift
//  Todo
//
//  Created by Yves Dukuze on 14/11/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
}
protocol NetworkClientContract {
    func request(_ request: RestRequestContract) async throws -> Data
}

struct NetworkClient: NetworkClientContract {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request(_ request: RestRequestContract) async throws -> Data {
        let urlRequest = try createRequest(request)
        return try await urlSession.data(for: urlRequest).0
    }
    
    func createRequest(_ request: RestRequestContract)throws -> URLRequest {
        guard request.url.count > 0, request.path.count > 0 else { throw NetworkError.invalidRequest }
        
        var urlComponnets = URLComponents(string: request.url + request.path)
        
        if request.type.rawValue == "GET" {
            var queryItems: [URLQueryItem] = []
            for (key, value) in request.params {
                queryItems.append( URLQueryItem(name: key, value: value))
            }
            urlComponnets?.queryItems = queryItems
        }
        guard let url = urlComponnets?.url else { throw NetworkError.invalidRequest }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.type.rawValue
        if request.type.rawValue == "POST" {
            let jsonData = try? JSONEncoder().encode(request.params)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = jsonData
        }
        return urlRequest
    }
}
