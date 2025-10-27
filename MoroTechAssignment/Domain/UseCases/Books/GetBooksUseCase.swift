//
//  GetBooksUseCase.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

final class GetBooksUseCase: BaseUseCase {
    typealias Input = URL?
    typealias Output = BooksRemoteDto
    
    private let repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(input: URL?) async throws -> BooksRemoteDto {
        try await repository.getBooks(path: input)
    }
}
