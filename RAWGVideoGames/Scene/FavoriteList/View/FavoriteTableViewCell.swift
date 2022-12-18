//
//  FavoriteTableViewCell.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteGameNameLabel: UILabel!
    
    func configureCell(favoriteGame: Games) {
        favoriteGameNameLabel.text = favoriteGame.gameName
    }
}
