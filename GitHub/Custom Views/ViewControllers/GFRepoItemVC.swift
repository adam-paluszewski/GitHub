//
//  GFRepoItemVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(title: "GitHub Profile", backgroundColor: .systemPurple, systemImage: SFSymbols.person)
    }
    
    
    override func actionButtontapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}

