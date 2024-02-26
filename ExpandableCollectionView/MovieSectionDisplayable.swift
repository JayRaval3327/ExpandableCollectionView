//
//  MovieSectionDisplayable.swift
//  ExpandableCollectionView
//
//  Created by Jay Raval on 2024-02-24.
//

import Foundation

struct MovieSectionDisplayable {
    let id = UUID().uuidString
    private(set) var isExpanded: Bool
    let movies: [MovieDisplayable]
    
    init(isExpanded: Bool, movies: [MovieDisplayable]) {
        self.isExpanded = isExpanded
        self.movies = movies
    }
    
    mutating 
    func toggleExpand() {
        self.isExpanded.toggle()
    }
}

extension MovieSectionDisplayable {
    init(from movieSection: [Movie]) {
        let moviesDisplayables = movieSection.map { MovieDisplayable(from: $0) }
        self.init(isExpanded: false, movies: moviesDisplayables)
    }
}

struct MovieDisplayable {
    let id: String
    let title: String
    let imageUrlString: String
    
    init(id: String, title: String, imageUrlString: String) {
        self.id = id
        self.title = title
        self.imageUrlString = imageUrlString
    }
}

extension MovieDisplayable {
    init(from movie: Movie) {
        self.init(id: movie.id , title: movie.metadata.title, imageUrlString: movie.metadata.iconicImage169)
    }
}
