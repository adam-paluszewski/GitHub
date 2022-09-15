//
//  FollowerCell.swift
//  GitHub
//
//  Created by Adam Paluszewski on 13/09/2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let cellId = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView()
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadAvatar(from: follower.avatarUrl)
    }
    
    
    private func configure() {
        addSubview(avatarImageView)
        
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
