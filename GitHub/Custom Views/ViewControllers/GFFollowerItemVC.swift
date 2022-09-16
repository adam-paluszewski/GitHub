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
        actionButton.set(title: "Get followers", backgroundColor: .systemCyan, systemImage: SFSymbols.person2)
    }
    
    
    override func actionButtontapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
