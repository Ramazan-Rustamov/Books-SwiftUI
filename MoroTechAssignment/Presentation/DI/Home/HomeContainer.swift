//
//  HomeContainer.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 27.10.25.
//

import Foundation

final class HomeContainer {
    let networkClient: NetworkClient
    let booksRepository: BooksRepository
    let getBooksUseCase: GetBooksUseCase

    init() {
        networkClient = NetworkClient()
        let remoteDataSource = BooksRemoteDataSource(networkClient: networkClient)
        booksRepository = BooksRepository(remoteDataSource: remoteDataSource)
        getBooksUseCase = GetBooksUseCase(repository: booksRepository)
    }
}
