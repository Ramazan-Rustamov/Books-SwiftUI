//
//  BookEntity+Mock.swift
//  MoroTechAssignmentTests
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation
@testable import MoroTechAssignment

extension AuthorEntity {
    static let mock: AuthorEntity = .init(name: "J.K. Rowling")
}

extension BookEntity {
    static let mock: BookEntity = .init(
        id: 1,
        title: "Harry Potter",
        authors: [.mock],
        formats: ["image/jpeg" : "https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg"]
    )
}

extension BooksRemoteDto {
    static let mock: BooksRemoteDto = .init(next: "https://gutendex.com/books", results: [.mock])
}
