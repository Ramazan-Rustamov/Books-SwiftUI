//
//  BaseUseCase.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import Foundation

protocol BaseUseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(input: Input) async throws -> Output
}
