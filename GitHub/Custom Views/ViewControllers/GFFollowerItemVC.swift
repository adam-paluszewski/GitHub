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
        itemInfoViewOne.set(itemInfoType: .followers, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.publicGists)
        actionButton.set(backgroundColor: .systemGreen, title: "Get followers", systemImageName: "person.2")
    }
    
    
    override func actionButtontapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
