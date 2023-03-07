//
//  GitHubSearchAPI.swift
//  SearchGitHubRepos
//
//  Created by NakCheon Jung on 2023/03/07.
//

import Foundation
import Combine
import Alamofire

class GitHubSearchAPIs {
    private enum Constants {
        static let baseURL = "https://api.github.com"
        static let searchRepositories = "/search/repositories"
        static let defaultHeaders: HTTPHeaders = [
            "accept" : "application/vnd.github.v3+json"
        ]
    }
    
    func searchRepositories(query: String) -> AnyPublisher<DataResponse<SearchRepositoryDTO, Error>?, Never> {
        let stringURL = Constants.baseURL + Constants.searchRepositories + "?q=" + query
        guard let encodedStringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        return AF.request(encodedStringURL, method: .get, parameters: ["q": query], headers: Constants.defaultHeaders)
            .publishDecodable(type: SearchRepositoryDTO.self)
            .map { response in
                response.mapError { error in
                    return NetworkError(initialError: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }    
}
