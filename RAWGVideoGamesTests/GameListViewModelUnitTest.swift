//
//  GameListViewModelUnitTest.swift
//  RAWGVideoGamesTests
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

@testable import RAWGVideoGames
import XCTest

final class GameListViewModelUnitTest: XCTestCase {

    var viewModel: GamesListViewModel!
    var fetchExpectation: XCTestExpectation!
    var game: GameModel!
    
    override func setUpWithError() throws {
                
        viewModel = GamesListViewModel()
        viewModel.delegate = self
    }
    
    func testFetchGamesIndexZero() {
        fetchExpectation = expectation(description: "fetchGames")
        
        XCTAssertNil(viewModel.getGames(at: 0))
        
        viewModel.fetchGames()
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getGames(at: 0)?.id, 3498)
    }
    
    
    func testGetGamesCount()  {
        fetchExpectation = expectation(description: "fetchGames")
        
        XCTAssertEqual(viewModel.getGamesCount(),0)
        
        viewModel.fetchGames()
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getGamesCount(), 20)
    }
    
    func testGetGamesIdAtIndexZero(at index: Int)  {
        fetchExpectation = expectation(description: "fetchGames")
        
        XCTAssertNil(viewModel.getGamesId(at:0))
        
        viewModel.fetchGames()
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(viewModel.getGamesId(at:0), 3409)
    }
    
}

extension GameListViewModelUnitTest: GamesListViewModelDelegate {
    func gamesLoaded() {
        fetchExpectation.fulfill()
    }
    
}
