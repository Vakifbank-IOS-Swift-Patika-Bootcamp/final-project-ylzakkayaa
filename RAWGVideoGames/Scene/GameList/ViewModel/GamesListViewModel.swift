//
//  GamesListViewModel.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import Foundation

protocol GamesListViewModelProtocol {
    var delegate: GamesListViewModelDelegate? { get set }
    func fetchGames()
    func fetchGamesOrderingReleased()
    func fetchGamesOrderingRating()
    func getGamesCount() -> Int
    func getGames(at index: Int) -> GameModel?
    func getGamesId(at index: Int) -> Int?
    func getSearchBar(character: String) -> [GameModel]?
}

protocol GamesListViewModelDelegate: AnyObject {
    func gamesLoaded()
}

final class GamesListViewModel: BaseViewController, GamesListViewModelProtocol {
    weak var delegate: GamesListViewModelDelegate?
    private var games: [GameModel]?
    private var filteredGames: [GameModel]?
    func fetchGames() {
        Client.getGames { [weak self] games, error in
        guard let self = self else { return }
        self.games = games
        self.delegate?.gamesLoaded()
        self.filteredGames = self.games
        }
    }
    
    func fetchGamesOrderingReleased() {
        Client.getGamesOrderingReleased { [weak self] games, error in
        guard let self = self else { return }
        self.games = games
        self.delegate?.gamesLoaded()
        self.filteredGames = self.games
        }
    }
    
    func fetchGamesOrderingRating() {
        Client.getGamesOrderingRating { [weak self] games, error in
        guard let self = self else { return }
        self.games = games
        self.delegate?.gamesLoaded()
        self.filteredGames = self.games
        }
    }
    
    
    func getGamesCount() -> Int {
        games?.count ?? 0
    }
    
    func getGames(at index: Int) -> GameModel? {
        games?[index]
    }
    
    func getGamesId(at index: Int) -> Int? {
        games?[index].id
    }
    
    func getSearchBar(character: String) -> [GameModel]? {
        if character == "" {
            games = filteredGames
        } else {
            games = filteredGames?.filter({$0.name.contains(character)})
        }
        self.delegate?.gamesLoaded()
        return games
    }
}

