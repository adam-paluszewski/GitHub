//
//  RepositoriesVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 16/09/2022.
//

import UIKit
import SafariServices

class RepositoriesVC: UIViewController {
    
    let tableView = UITableView()
    
    var username: String!
    var repos: [Repos] = []
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
        fetchRepos()
    }
    

  
    func configureViewController() {
        navigationItem.title = "\(username!)'s repos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func fetchRepos() {
        NetworkManager.shared.getRepos(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let repos):
                    DispatchQueue.main.async {
                        self.repos = repos
                        self.tableView.reloadDataOnMainThread()
                    }
                case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: SFSymbols.error)
            }
        }
    }
}


extension RepositoriesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.cellId, for: indexPath) as! RepositoryCell
        let repo = repos[indexPath.row]
        cell.set(repo: repo)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoName = repos[indexPath.row].name
        let repoUrlString = "https://github.com/\(username!)/\(repoName)"
        let url = URL(string: repoUrlString)!
        print(url)
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemIndigo
        present(safariVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
