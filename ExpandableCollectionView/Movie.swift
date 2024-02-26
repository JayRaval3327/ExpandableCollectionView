//
//  Movie.swift
//  ExpandableCollectionView
//
//  Created by Jay Raval on 2024-02-24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? JSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let movies: [[Movie]]
}

// MARK: - Movie
struct Movie: Codable {
    let id: String
    let layout: Layout
    let metadata: Metadata
}

enum Layout: String, Codable {
    case contentItem = "CONTENT_ITEM"
}

// MARK: - Metadata
struct Metadata: Codable {
    let contentID: Int
    let contentType: ContentType
    let longDescription, year, title: String
    let duration: Int
    let contentSubtype: ContentSubtype
    let language: Language
    let pcLevel: Int
    let genres: [String]
    let rating: String
    let image23, iconicImage169, iconicImage23, image169: String

    enum CodingKeys: String, CodingKey {
        case contentID = "contentId"
        case contentType, longDescription, year, title, duration, contentSubtype, language, pcLevel, genres, rating, image23, iconicImage169, iconicImage23, image169
    }
}

enum ContentSubtype: String, Codable {
    case movie = "MOVIE"
}

enum ContentType: String, Codable {
    case vod = "VOD"
}

enum Language: String, Codable {
    case eng = "ENG"
}
