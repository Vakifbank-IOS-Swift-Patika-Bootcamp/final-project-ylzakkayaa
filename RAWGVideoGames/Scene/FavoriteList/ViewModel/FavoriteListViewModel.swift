//
//  FavoriteListViewModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

protocol FavoriteListViewModelProtocol {
    var delegate: FavoriteListViewModelDelegate? { get set }
    func fetchFavoriteGames()
    func getFavoriteCount() -> Int
    func getFavoriteGame(at index: Int) -> Games?
    func notification()
}

protocol FavoriteListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class FavoriteListViewModel: FavoriteListViewModelProtocol {
    
    var delegate: FavoriteListViewModelDelegate?
    private var favoriteGames: [Games]?
    
    func fetchFavoriteGames() {
        favoriteGames = CoreDataManager.shared.getFavorites()
        self.delegate?.gamesLoaded()
    }
    
    func getFavoriteCount() -> Int {
        return favoriteGames?.count ?? 0
    }
    
    func getFavoriteGame(at index: Int) -> Games? {
        return favoriteGames?[index]
    }
    
    func notification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleButtonPressed),
                                               name: NSNotification.Name("addNewFavoriteGame"),
                                               object: nil)
    }
    
    @objc func handleButtonPressed(_ notification: Notification) {
        fetchFavoriteGames()
    }
}
