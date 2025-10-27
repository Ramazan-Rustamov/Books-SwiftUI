//
//  BooksRepository.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

protocol BooksRepositoryProtocol {
    func getBooks(path: URL?) async throws -> BooksRemoteDto
}

final class BooksRepository: BooksRepositoryProtocol {
    private let remoteDataSource: BooksRemoteDataSourceProtocol
    
    init(remoteDataSource: BooksRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getBooks(path: URL? = nil) async throws -> BooksRemoteDto {
        try await remoteDataSource.getBooks(path: path)
    }
}
