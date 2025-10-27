//
//  NetworkTests.swift
//  MoroTechAssignmentTests
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation
@testable import MoroTechAssignment
import Testing

struct NetworkTests {
    
    @Test func fetchBooksSuccess() async {
        let networkClient: MockNetworkClient = MockNetworkClient()
        let response: String = """
            {
            "next": "https://gutendex.com/books",
            "results": [
            {"id": 1,
            "title": "Harry Potter",
            "authors": [{"name":"J.K. Rowling"}],
            "formats": {"image/jpeg":"https://www.gutenberg.org/cache/epub/84/pg84.cover.medium.jpg"}
            }
            ]
            }
            """
        networkClient.mockData = response.data(using: .utf8)
        let expectedResult: BooksRemoteDto = .mock
        do {
            let actualResult: BooksRemoteDto = try await networkClient.request(GetBooksRequest())
            #expect(expectedResult == actualResult)
        } catch {
            assertionFailure()
        }
    }
    
    @Test func fetchBooksFailure() async {
        let networkClient: MockNetworkClient = MockNetworkClient()
        networkClient.mockError = NetworkError.badResponse
        let expectedResult: Error = NetworkError.badResponse
        do {
            let _ : BooksRemoteDto = try await networkClient.request(GetBooksRequest())
            assertionFailure()
        } catch {
            #expect(expectedResult.localizedDescription == error.localizedDescription)
        }
    }
}
