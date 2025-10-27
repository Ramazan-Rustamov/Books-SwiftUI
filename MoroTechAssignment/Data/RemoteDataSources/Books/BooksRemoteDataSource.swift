//
//  BooksRemoteDataSource.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

protocol BooksRemoteDataSourceProtocol {
    func getBooks(path: URL?) async throws -> BooksRemoteDto
}

final class BooksRemoteDataSource: BooksRemoteDataSourceProtocol {
    private let networkClient: NetworkProtocol
    
    init(networkClient: NetworkProtocol) {
        self.networkClient = networkClient
    }
    
    func getBooks(path: URL? = nil) async throws -> BooksRemoteDto {
        var request = GetBooksRequest()
        
        if let path {
            request.path = path
        }
        
        return try await networkClient.request(request)
    }
}
