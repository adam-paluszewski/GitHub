//
//  GFRepoItemVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit
import SafariServices

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(title: "Show repos", backgroundColor: .systemBlue, systemImage: SFSymbols.repos)
    }
    
    
    override func actionButtontapped() {
        let reposVC = RepositoriesVC(username: user.login)
//        present(reposVC, animated: true)
        navigationController?.pushViewController(reposVC, animated: true)
    }
}

