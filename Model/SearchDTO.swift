//
//  SearchDTO.swift
//  SearchGitHubRepos
//
//  Created by NakCheon Jung on 2023/03/07.
//

import Foundation

struct SearchRepositoryDTO: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [RepoInfo]
}

struct RepoInfo: Decodable {
    let id: Int
    let name: String
    let full_name: String
    let html_url: String
    let description: String?
    let owner: User
}

struct User: Decodable {
    let id: Int
    let login: String
}
