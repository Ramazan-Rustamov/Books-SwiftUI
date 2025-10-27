//
//  GetBooksRequest.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

nonisolated struct GetBooksRequest: NetworkRequest {
    var path: URL = URL(string: "https://gutendex.com/books")!
    
    var method: HTTPMethod {
        .get
    }
}
