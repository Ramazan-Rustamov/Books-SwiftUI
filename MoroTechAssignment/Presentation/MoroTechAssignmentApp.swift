//
//  MoroTechAssignmentApp.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import SwiftUI

@main
struct MoroTechAssignmentApp: App {
    private let homeContainer = HomeContainer()
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: HomeViewModel(
                    getBooksUseCase: homeContainer.getBooksUseCase
                )
            )
        }
    }
}
