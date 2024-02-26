//
//  ViewModel.swift
//  ExpandableCollectionView
//
//  Created by Jay Raval on 2024-02-24.
//

import Foundation

enum JsonError: String, Error {
    case unableToLoadJson = "Unable to load JSON"
    case unableToDecodeJson = "Unable to decode JSON"
}

final class ViewModel {
    
    @Published private(set) var movies: [MovieSectionDisplayable] = []
    
    init() { }
    
    func getMovies() {
        let result = fetchMovies()
        
        switch result {
        case .success(let resultMovies):
            print(resultMovies)
            self.movies = resultMovies.movies.map({ MovieSectionDisplayable(from: $0) })
        case .failure(let error):
            print(error.rawValue)
        }
    }
    
    func didTapSection(_ section: Int) {
        self.movies[section].toggleExpand()
    }
    
    private func fetchMovies() -> Result<Movies, JsonError>{
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else { return.failure(.unableToLoadJson) }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Movies.self, from: data)
            let movies = jsonData
            return.success(movies)
        } catch {
            return.failure(.unableToDecodeJson)
        }
    }
}
