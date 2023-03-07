//
//  NetworkDTO.swift
//  SearchGitHubRepos
//
//  Created by NakCheon Jung on 2023/03/07.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
}
