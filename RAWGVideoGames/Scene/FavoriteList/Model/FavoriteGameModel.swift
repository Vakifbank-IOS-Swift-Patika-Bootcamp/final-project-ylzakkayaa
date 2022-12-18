//
//  FavoriteGameModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

struct FavoriteGameModel: Decodable {
    let id: Int
    let name: String
    let playtime: Int?
    let platforms: [FavoritePlatform]?
    let released: String?
    let image: String?
    let rating: Double?
    let ratings: [FavoriteRating]?
    let ratingsCount: Int?
    let genres: [FavoriteGenre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case playtime
        case platforms
        case released
        case image = "background_image"
        case rating
        case ratings
        case ratingsCount = "ratings_count"
        case genres
    }
}

struct FavoritePlatform: Decodable {
    let platform: FavoritePlatformInfo
}

struct FavoritePlatformInfo: Decodable {
    let id: Int
    let name: String
    let slug: String
}

struct FavoriteRating: Decodable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

struct FavoriteGenre: Decodable {
    let id: Int
    let name: String
    let slug: String
}
