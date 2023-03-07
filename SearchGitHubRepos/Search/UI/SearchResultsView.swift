//
//  SearchResultsView.swift
//  SearchGitHubRepos
//
//  Created by NakCheon Jung on 2023/03/07.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        SearchBar(viewModel: viewModel)
            .padding(20)
        
        List(viewModel.searchResults) { item in
            ResultCell(repo: item, viewModel: viewModel)
        }
        .listStyle(.plain)
    }
}

struct ResultCell: View {
    @ObservedObject private var viewModel: SearchViewModel
    @State private var repo: SearchViewModel.Repo
    
    init(repo: SearchViewModel.Repo, viewModel: SearchViewModel) {
        self.repo = repo
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repo.name)
                .font(.system(size: 20, weight: .bold))
            Text(repo.owenr)
                .font(.system(size: 16, weight: .regular))
        }
    }
}

