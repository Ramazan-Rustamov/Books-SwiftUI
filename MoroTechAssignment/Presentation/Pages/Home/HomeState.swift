//
//  HomeState.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

struct HomeState: Hashable, Equatable {
    var isLoading: Bool = false
    var error: String? = nil
    var nextPath: URL? = nil
    var allBooks: [BookEntity] = []
    var favouriteIDs: Set<Int> = []
    var hasReachedFinalPage: Bool = false
    var bookDemonstrationType: BookDemonstrationType = .all
}

enum BookDemonstrationType: String, Hashable, Equatable, CaseIterable {
    case all = "All"
    case favourites = "Favourites"
}
