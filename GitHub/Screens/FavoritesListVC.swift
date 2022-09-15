//
//  FavoritesListVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 12/09/2022.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    
    var favorites: [Follower] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellId)
        tableView.rowHeight = 80
        tableView.removeExcessCells()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
  
    func getFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
                case .success(let favorites):
                    self.updateUI(with: favorites)
                case .failure(let error):
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

                
    func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            showEmptyStateView(with: "You have no favorites. Add some 😊", in: self.view)
        } else {
            DispatchQueue.main.async {
                self.favorites = favorites
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}


extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellId, for: indexPath) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let followerListVC = FollowersListVC(username: favorite.login)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { error in
            guard let error = error  else {
                favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            presentGFAlert(title: "Error", message: error.rawValue, buttonTitle: "OK")
        }
        

        
    }
}
