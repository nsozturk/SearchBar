//
//  ApiService.swift
//  SearchBar
//
//  Created by enes ozturk on 6.05.2023.
//

import UIKit

struct Constants {
    static let apiKey = "TMDB_API_KEY"
}

class APIService {
    static var shared = APIService()
    let session = URLSession(configuration: .default)

    func getMovies(for Query: String, completion: @escaping ([Title]?, Error?) -> Void) {
        guard let FormatedQuery = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        guard let SEARCH_URL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apiKey)&query=\(FormatedQuery)") else { print("INVALID")
            return
        }

        let task = session.dataTask(with: SEARCH_URL) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    //   print(decodedData)
                    completion(decodedData.results, nil)
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
