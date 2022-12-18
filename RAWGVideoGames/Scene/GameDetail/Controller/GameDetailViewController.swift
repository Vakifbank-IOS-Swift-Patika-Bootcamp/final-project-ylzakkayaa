//
//  GameDetailViewController.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

final class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameReleasedDateLabel: UILabel!
    @IBOutlet weak var gameUpdateDateLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var screenShotsCount: UILabel!
    @IBOutlet weak var moviesCount: UILabel!
    var gameId: Int?
    private var selectedGame: String = ""
    private var isFavorite: String = ""
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
        isFavorite = viewModel.getIsFavorite(gameId: gameId!)
        favoriteButtonOutlet.setImage(UIImage(systemName: "\(isFavorite)"), for: .normal)
    }
    @IBAction func favoriteButton(_ sender: Any) {
        selectedGame = (viewModel.getAddorDeleteFavorite(gameId: gameId!))
        favoriteButtonOutlet.setImage(UIImage(systemName: "\(selectedGame)"), for: .normal)
   }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        gameReleasedDateLabel.text = "Released Date: ".localized() + viewModel.getGameReleased()
        gameNameLabel.text = viewModel.getGameName()
        guard let url = viewModel.getGameImageURL() else { return }
        gameImage.sd_setImage(with: url)
        gameUpdateDateLabel.text = "Updated Date: ".localized() + viewModel.getGameUpdate()
        gameRatingLabel.text = "Rating: ".localized() + String(viewModel.getGameRating())
        gameDescriptionLabel.text = "Description: ".localized() + viewModel.getGameDescription()
        playTime.text = String(viewModel.playTime())
        screenShotsCount.text = String(viewModel.screenShotsCount())
        moviesCount.text = String(viewModel.moviesCount())
    }
}
