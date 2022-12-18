//
//  GameDetailViewModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    func fetchGameDetail(id: Int)
    func getGameImageURL() -> URL?
    func getGameName() -> String
    func getGameReleased() -> String
    func getGameUpdate() -> String
    func getGameRating() -> Double
    func getGameDescription() -> String
    func getAddorDeleteFavorite(gameId: Int) -> String
    func getIsFavorite(gameId: Int) -> String
    func playTime() -> Int
    func moviesCount() -> Int
    func screenShotsCount() -> Int
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {
    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    var games: [Games] = []
    var coreDataId: Games?
    
    func fetchGameDetail(id: Int) {
        Client.getSelectedGame(id: id) { [weak self] gameDetail, error in
            guard let self = self else { return }
            self.game = gameDetail
            self.delegate?.gameLoaded()
        }
    }
    
    func getGameImageURL() -> URL? {
        URL(string: game?.image ?? "")
    }
    
    func getGameName() -> String {
        return game?.name ?? "Unknow"
    }
    
    func getGameReleased() -> String {
        return game?.release ?? "Unknow"
    }
    
    func getGameUpdate() -> String {
        return game?.update ?? "Unknow"
    }
    
    func getGameRating() -> Double {
        return (game?.rating!)!
    }
    
    func getGameDescription() -> String {
        return game?.descriptionRaw ?? "Unknow"
    }
    
    func playTime() -> Int {
        return game?.playTime ?? 0
    }
    
    func screenShotsCount() -> Int {
        return game?.screenShotsCount ?? 0
    }
    
    func moviesCount() -> Int {
        return game?.moviesCount ?? 0
    }
    
    //CoreDatayı kontrol ediyorum. Cora datada varsa silme işlemini yapıyorum ve kalbin içini boşaltıyorum, core datada yoksa core dataya ekleyip kalbin içini dolduruyorum.
    func getAddorDeleteFavorite(gameId: Int) -> String {
        if CoreDataManager.shared.getSelectedFavorite(id: gameId) == true {
            CoreDataManager.shared.deleteFavorite(gameId: game!.id)
            NotificationCenter.default.post(name: NSNotification.Name("addNewFavoriteGame"), object: games)
            return "heart"
        } else {
            games.append(CoreDataManager.shared.saveFavorite(favoriteGameName: game!.name, gameId: game!.id)!)
            NotificationCenter.default.post(name: NSNotification.Name("addNewFavoriteGame"), object: games)
            return "heart.fill"
        }
    }
    
    //Favori olup olmamasına göre kalbin nasıl görüneceğini belirliyorum.
    func getIsFavorite(gameId: Int) -> String {
        if CoreDataManager.shared.getSelectedFavorite(id: gameId) == true {
            return "heart.fill"
        } else {
            return "heart"
        }
    }
}
