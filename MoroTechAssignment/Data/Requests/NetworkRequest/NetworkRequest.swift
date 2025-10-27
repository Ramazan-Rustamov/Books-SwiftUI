//
//  NetworkRequest.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

protocol NetworkRequest {
    nonisolated var path: URL { get set }
    nonisolated var method: HTTPMethod { get }
    nonisolated var headers: [String: String] { get }
    nonisolated var body: (any Encodable)? { get }
    nonisolated var query: [URLQueryItem] { get }
}

extension NetworkRequest {
    var query: [URLQueryItem] { [] }
    var body: (any Encodable)? { nil }
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}
