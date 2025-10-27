//
//  NetworkClient.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

import Foundation

protocol NetworkProtocol {
    func request<T: Decodable & Sendable>(_ request: NetworkRequest) async throws -> T
}

actor NetworkClient: NetworkProtocol {
    private var session: URLSession { .shared }
            
    private func createURLRequest(from request: NetworkRequest) -> URLRequest {
        var url = request.path
        if !request.query.isEmpty {
            url = url.appending(queryItems: request.query)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let bodyData = request.body {
            urlRequest.httpBody = try? JSONEncoder().encode(bodyData)
        }

        return urlRequest
    }
    
    private func checkStatusCode(_ response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.badResponse
        }
        
        if 200..<300 ~= statusCode {
            return
        }
        
        if statusCode == 401 {
            throw NetworkError.unauthorized
        }
        
        if 400..<500 ~= statusCode {
            throw NetworkError.clientError
        }
        
        if statusCode >= 500 {
            throw NetworkError.serverError
        }
    }
    
    func request<T: Decodable & Sendable>(_ request: NetworkRequest) async throws -> T {
        do {
            let request = createURLRequest(from: request)
            let (data,response) = try await session.data(for: request)
            
            self.log(request: request, data: data, response: response)
            try self.checkStatusCode(response)
            
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    private func log(request: URLRequest, data: Data, response: URLResponse) {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return
        }
        let emptyMessage = "IS EMPTY"
        
        let url = request.url?.absoluteString ?? emptyMessage
        let headers = request.allHTTPHeaderFields ?? [:]
        let body = request.httpBody
        let method = request.httpMethod ?? emptyMessage
        
        print("START ----------------------------------\n")
        print("URL: \(url)\n")
        print("METHOD: \(method)\n")
        print("HEADERS: \(headers)\n")
        print("BODY: \(String(decoding: body ?? Data(), as: UTF8.self))\n")
        print("STATUS CODE: \(statusCode)\n")
        print("Response: \(String(decoding: data, as: UTF8.self))\n")
        print("END ----------------------------------\n\n")
    }
}

enum NetworkError: Error, Equatable {
    case badResponse
    case unauthorized
    case clientError
    case serverError
    case decodingError
}
