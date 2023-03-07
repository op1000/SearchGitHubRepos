//
//  SearchBar.swift
//  SearchGitHubRepos
//
//  Created by NakCheon Jung on 2023/03/07.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject private var viewModel: SearchViewModel
    @State private var isEditing = false
    @FocusState private var isFocused
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.isFocused = false
    }
        
    var body: some View {
        HStack {
            TextField("Search", text: $viewModel.searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                viewModel.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.leading, 20)
                .padding(.trailing, isEditing ? 10 : 20)
                .onTapGesture {
                    isEditing = true
                    isFocused = true
                }
                .focused($isFocused)
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    isFocused = false
                    viewModel.searchText = ""
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
            }
        }
    }
}

