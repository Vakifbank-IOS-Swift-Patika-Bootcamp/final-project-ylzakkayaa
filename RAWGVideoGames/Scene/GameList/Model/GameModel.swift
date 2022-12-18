//
//  GameModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

struct GameModel: Decodable {
    let id: Int
    let name: String
    let playtime: Int?
    let platforms: [Platform]?
    let released: String?
    let image: String?
    let rating: Double?
    let ratings: [Rating]?
    let ratingsCount: Int?
    let genres: [Genre]?
    
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

struct Platform: Decodable {
    let platform: PlatformInfo
}

struct PlatformInfo: Decodable {
    let id: Int
    let name: String
    let slug: String
}

struct Rating: Decodable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let slug: String
}

