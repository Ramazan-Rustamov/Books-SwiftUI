//
//  HomeViewModel.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    private let getBooksUseCase: GetBooksUseCase
    @Published var state: HomeState = .init()
    
    var books: [BookEntity] {
        switch state.bookDemonstrationType {
        case .all:
            state.allBooks
        case .favourites:
            state.allBooks.filter { state.favouriteIDs.contains($0.id) }
        }
    }
    
    init(getBooksUseCase: GetBooksUseCase) {
        self.getBooksUseCase = getBooksUseCase
        
        Task(priority: .userInitiated) { await self.getBooks() }
    }
    
    func getBooks() async {
        defer { state.isLoading = false }
        state.isLoading = true
        
        do {
            let response = try await self.getBooksUseCase.execute(input: self.state.nextPath)
            state.hasReachedFinalPage = response.next == nil
            state.nextPath = URL(string: response.next ?? "")
            state.allBooks += response.results
        } catch {
            state.error = error.localizedDescription
        }
    }
    
    func changeFavouriteStatus(_ id: Int) {
        if state.favouriteIDs.contains(id) {
            state.favouriteIDs.remove(id)
        } else {
            state.favouriteIDs.insert(id)
        }
    }
    
    func canFetchNextPage() -> Bool {
        !state.isLoading &&
        !state.hasReachedFinalPage &&
        !state.allBooks.isEmpty &&
        state.bookDemonstrationType != .favourites
    }
}
