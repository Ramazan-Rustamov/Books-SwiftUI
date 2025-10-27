//
//  HomeTests.swift
//  MoroTechAssignmentTests
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation
@testable import MoroTechAssignment
import Testing

@MainActor
struct HomeTests {
    
    func initializeNewViewModel() -> HomeViewModel {
        let homeContainer = HomeContainer()
        return HomeViewModel(getBooksUseCase: homeContainer.getBooksUseCase)
    }
    
    @Test func testMarkingAsFavourite() {
        let viewModel = initializeNewViewModel()
        let book: BookEntity = .mock
        
        viewModel.changeFavouriteStatus(book.id)
        #expect(!viewModel.state.favouriteIDs.isEmpty)
        
        viewModel.changeFavouriteStatus(book.id)
        #expect(viewModel.state.favouriteIDs.isEmpty)
    }
    
    @Test func testFiltrationOfFavouriteBooks() {
        let viewModel = initializeNewViewModel()
        let book: BookEntity = .mock
        viewModel.state.allBooks = [book]
        viewModel.state.bookDemonstrationType = .all
        #expect(viewModel.books.count == 1)
        
        viewModel.state.bookDemonstrationType = .favourites
        #expect(viewModel.books.isEmpty)
        
        viewModel.changeFavouriteStatus(book.id)
        #expect(viewModel.books.count == 1)
    }
}
