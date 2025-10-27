//
//  HomeView.swift
//  MoroTechAssignment
//
//  Created by Ramazan Rustamov on 26.10.25.
//

import SwiftUI
import NukeUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            segmentedControlView
            booksList
        }
        .loading(viewModel.state.isLoading)
    }
    
    private var segmentedControlView: some View {
        Picker("", selection: $viewModel.state.bookDemonstrationType) {
            ForEach(BookDemonstrationType.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    private var booksList: some View {
        List {
            ForEach(viewModel.books) { book in
                BookRow(
                    data: book,
                    isFavourite: viewModel.state.favouriteIDs.contains(book.id)
                ) {
                    viewModel.changeFavouriteStatus(book.id)
                }
            }
            paginationView
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private var paginationView: some View {
        if viewModel.canFetchNextPage() {
            Spacer(minLength: 1)
                .onAppear {
                    Task(priority: .userInitiated) { await viewModel.getBooks() }
                }
        } else {
            EmptyView()
        }
    }
    
    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
}

private struct BookRow: View {
    let data: BookEntity
    let isFavourite: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            imageView
                .padding(5)
            titleAndAuthorLabels
                .padding(5)
            Spacer()
            favouriteView
                .padding(5)
        }
        .listRowSeparator(.hidden)
    }
    
    private var imageView: some View {
        LazyImage(url: data.imageUrl) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }  else if state.error != nil || state.isLoading {
                Text(data.placeholderText)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(
                        Circle()
                            .fill(.secondary)
                    )
            }
        }
    }
    
    private var titleAndAuthorLabels: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(data.title)
                .font(.system(size: 16))
                .foregroundStyle(.primary)
                .lineLimit(2)
            Text(data.authorsText)
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
        }
    }
    
    private var favouriteView: some View {
        Button {
            action()
        } label: {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .frame(width: 40, height: 40)
                .foregroundStyle(.red)
        }
    }
}
