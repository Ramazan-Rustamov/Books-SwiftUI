//
//  MockNetworkClient.swift
//  MoroTechAssignmentTests
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation
@testable import MoroTechAssignment

final class MockNetworkClient: NetworkProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func request<T>(_ request: any NetworkRequest) async throws -> T where T : Decodable, T : Sendable {
        if let mockError {
            throw mockError
        }
        
        guard let mockData else {
            throw NetworkError.badResponse
        }
        
        return try JSONDecoder().decode(T.self, from: mockData)
    }
}
