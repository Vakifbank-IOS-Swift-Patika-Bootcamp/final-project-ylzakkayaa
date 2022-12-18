//
//  ViewController.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit

class GamesListViewController: BaseViewController {
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    var menuOut = false
    
    @IBOutlet weak var gameListTableView: UITableView!{
        didSet {
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
            gameListTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        }
    }
    
    private var GameViewModel: GamesListViewModelProtocol = GamesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameViewModel.delegate = self
        indicator.startAnimating()
        GameViewModel.fetchGames()
        searchBar.delegate = self
    }
    
    @IBAction func orderingMenu(_ sender: Any) {
        if menuOut == false {
            barButtonLayout(hidden: 0)
        } else {
            barButtonLayout(hidden: 1)
        }
    }
    
    @IBAction func orderingName(_ sender: Any) {
        indicator.startAnimating()
        GameViewModel.fetchGames()
        barButtonLayout(hidden: 1)
    }
    
    @IBAction func orderingReleased(_ sender: Any) {
        indicator.startAnimating()
        GameViewModel.fetchGamesOrderingReleased()
        barButtonLayout(hidden: 1)
    }
    
    @IBAction func orderingRating(_ sender: Any) {
        indicator.startAnimating()
        GameViewModel.fetchGamesOrderingRating()
        barButtonLayout(hidden: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension GamesListViewController: GamesListViewModelDelegate {
    func gamesLoaded() {
        indicator.stopAnimating()
        gameListTableView.reloadData()
    }
}

extension GamesListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GameViewModel.getGamesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameTableViewCell, let model = GameViewModel.getGames(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(game: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 //Cell height
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        GameViewModel.getSearchBar(character: text)
    }
}

extension GamesListViewController {
    func barButtonLayout(hidden: Int) {
        if hidden == 1 {
            trailing.constant = 0
            leading.constant = 0
            menuOut = false
        } else {
            trailing.constant = -100
            leading.constant = 100
            menuOut = true
        }
    }
}

