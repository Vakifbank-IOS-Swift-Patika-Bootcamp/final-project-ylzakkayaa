//
//  GetGamesResponseModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation
 
struct GetGamesResponseModel: Decodable {
    let results: [GameModel]
}
