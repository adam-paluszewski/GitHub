//
//  GFFollowerItemVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        actionButton.set(title: "Show followers", backgroundColor: .systemIndigo, systemImage: SFSymbols.person2)
    }
    
    
    override func actionButtontapped() {
        let followersListVC = FollowersListVC(username: user.login)
        followersListVC.isModalInPresentation = true
        let navController = UINavigationController(rootViewController: followersListVC)
        navigationController?.present(navController, animated: true)
    }
}
