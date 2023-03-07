//
//  SearchViewModel.swift
//  SearchGitHubRepos
//
//  Created by NakCheon Jung on 2023/03/07.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    struct Repo: Identifiable {
        let id: Int
        let name: String
        let owenr: String
        let link: String
    }
    @Published var searchText: String
    @Published var searchResults: [Repo] = []
    private var searchAPI: GitHubSearchAPIs
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(searchText: String = "", searchAPI: GitHubSearchAPIs = GitHubSearchAPIs()) {
        self.searchText = searchText
        self.searchAPI = searchAPI
        self.bind()
    }
}

extension SearchViewModel {
    func bind() {
        $searchText
            .filter { !$0.isEmpty }
            .flatMap { [unowned self] query in
                return self.searchAPI.searchRepositories(query: query)
            }
            .sink { [weak self] response in
                guard let self else { return }
                guard response?.error == nil, let data = response?.value else {
                    return
                }
                self.searchResults = data.items.map {
                    Repo(id: $0.id, name: $0.name, owenr: $0.owner.login, link: $0.html_url)
                }
            }
            .store(in: &cancellableSet)
    }
}
