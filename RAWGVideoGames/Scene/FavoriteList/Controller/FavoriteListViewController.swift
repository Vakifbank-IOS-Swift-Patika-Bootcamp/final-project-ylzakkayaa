//
//  FavoriteListViewController.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var favoriteListTableView: UITableView! {
        didSet {
            favoriteListTableView.delegate = self
            favoriteListTableView.dataSource = self
            favoriteListTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        }
    }
    
    private var favoriteViewModel: FavoriteListViewModelProtocol = FavoriteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteViewModel.delegate = self
        favoriteViewModel.fetchFavoriteGames()
        favoriteViewModel.notification()
    }
    
}

extension FavoriteListViewController: FavoriteListViewModelDelegate {
    func gamesLoaded() {
        favoriteListTableView.reloadData()
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteViewModel.getFavoriteCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as? FavoriteTableViewCell, let model = favoriteViewModel.getFavoriteGame(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(favoriteGame: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44 //Cell height
    }
}
