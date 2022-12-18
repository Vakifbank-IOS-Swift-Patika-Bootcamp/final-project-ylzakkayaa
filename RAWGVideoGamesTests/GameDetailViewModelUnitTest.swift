//
//  GameDetailViewModelUnitTest.swift
//  RAWGVideoGamesTests
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

@testable import RAWGVideoGames
import XCTest

final class GameDetailViewModelUnitTest: XCTestCase {

    var viewModel: GameDetailViewModel!
    var fetchExpectation: XCTestExpectation!
    var game: GameDetailModel!
    
    override func setUpWithError() throws {
                
        game = GameDetailModel(id: 3498,
                               name: "Grand Theft Auto V",
                               platforms: [ Platform(platform: PlatformInfo(id: 1, name: "PC",slug: "pc"))],
                               release: "2013-09-17",
                               update: "2013-09-17",
                               image: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", rating: 4.47, ratings: [
                                   Rating(id: 5, title: "exceptional", count: 3615, percent: 59.11),
                                   Rating(id: 4, title: "recommended", count: 2004, percent: 32.77),
                                   Rating(id: 3, title: "meh", count: 385, percent: 6.29),
                                   Rating(id: 2, title: "skip", count: 112, percent: 1.83)],
                               ratingsCount: 6040,
                               genres: [Genre(id: 4, name: "Action", slug: "action")],
                               descriptionRaw: "Rockstar Games went bigger, since their previous installment of the series. You get the complicated and realistic world-building from Liberty City of GTA4 in the setting of lively and diverse Los Santos, from an old fan favorite GTA San Andreas. 561 different vehicles (including every transport you can operate) and the amount is rising with every update. \nSimultaneous storytelling from three unique perspectives: \nFollow Michael, ex-criminal living his life of leisure away from the past, Franklin, a kid that seeks the better future, and Trevor, the exact past Michael is trying to run away from. \nGTA Online will provide a lot of additional challenge even for the experienced players, coming fresh from the story mode. Now you will have other players around that can help you just as likely as ruin your mission. Every GTA mechanic up to date can be experienced by players through the unique customizable character, and community content paired with the leveling system tends to keep everyone busy and engaged.",
                               playTime: 72, screenShotsCount: 57, moviesCount: 8, creatorsCount: 11)

        viewModel = GameDetailViewModel(game: game)
        viewModel.delegate = self
    }
    
    func testGetImageURL() {
        XCTAssertEqual(viewModel.getGameImageURL(), URL(string: game.image ?? ""))
    }
    
    func testGetGameName() {
        XCTAssertEqual(viewModel.getGameName(), game.name)
    }
    
    func testGetGameReleased() {
        XCTAssertEqual(viewModel.getGameReleased(), game.release)
    }
    
    func testGetGameUpdate() {
        XCTAssertEqual(viewModel.getGameUpdate(), game.update)
    }
    
    func testGetGameRating() {
        XCTAssertEqual(viewModel.getGameRating(), game.rating)
    }
    
    func testGetGameDescription() {
        XCTAssertEqual(viewModel.getGameDescription(), game.descriptionRaw)
    }
    
    func testgetPlayTime() {
        XCTAssertEqual(viewModel.playTime(), game.playTime)
    }
    
    func testGetScreenShotsCount() {
        XCTAssertEqual(viewModel.screenShotsCount(), game.screenShotsCount)
    }
    
    func testMoviesCount() {
        XCTAssertEqual(viewModel.moviesCount(), game.moviesCount)
    }

}
extension GameDetailViewModelUnitTest: GameDetailViewModelDelegate {
    func gameLoaded() {
        fetchExpectation.fulfill()
    }
}
