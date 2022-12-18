//
//  GameTableViewCell.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit
import SDWebImage

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    var gamePlatforms : String = ""
    
    func configureCell(game: GameModel) {
        gameLabel.text = game.name
        if game.image == nil {
            gameImage.sd_setImage(with: URL(string: "https://nebosan.com.tr/wp-content/uploads/2018/06/no-image.jpg"))
        } else {
            gameImage.sd_setImage(with: URL(string: game.image!))
        }
        ratingLabel.text = String(game.rating!)
        releasedDateLabel.text = "Released Date: ".localized() + (game.released ?? "")
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
    
}

