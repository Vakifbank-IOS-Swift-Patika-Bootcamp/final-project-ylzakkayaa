//
//  GameDetailModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

struct GameDetailModel: Decodable {
    let id: Int
    let name: String
    let platforms: [Platform]?
    let release: String?
    let update: String?
    let image: String?
    let rating: Double?
    let ratings: [Rating]?
    let ratingsCount: Int?
    let genres: [Genre]?
    let descriptionRaw: String?
    let playTime: Int?
    let screenShotsCount : Int?
    let moviesCount : Int?
    let creatorsCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case platforms
        case release = "released"
        case update = "updated"
        case image = "background_image"
        case rating
        case ratings
        case ratingsCount = "ratings_count"
        case genres
        case descriptionRaw = "description_raw"
        case playTime = "playtime"
        case screenShotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
    }
}



