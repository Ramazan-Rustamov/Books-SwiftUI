//
//  BooksEntity.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

nonisolated struct BooksRemoteDto: Decodable, Sendable, Hashable, Equatable {
    let next: String?
    let results: [BookEntity]
    
    init(next: String?, results: [BookEntity]) {
        self.next = next
        self.results = results
    }
}

nonisolated struct BookEntity: Decodable, Sendable, Hashable, Equatable, Identifiable {
    let id: Int
    let title: String
    let authors: [AuthorEntity]
    let formats: [String: String]
    
    init(id: Int, title: String, authors: [AuthorEntity], formats: [String : String]) {
        self.id = id
        self.title = title
        self.authors = authors
        self.formats = formats
    }
}

nonisolated struct AuthorEntity: Decodable, Sendable, Hashable, Equatable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension BookEntity {
    var imageUrl: URL? {
        URL(string: formats["image/jpeg"] ?? "")
    }
    
    var placeholderText: String {
        String(title.prefix(1))
    }
    
    var authorsText: String {
        authors.lazy.map { $0.name }.joined(separator: "; ")
    }
}
