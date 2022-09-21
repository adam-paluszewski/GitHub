//
//  GFUserInfoHeaderVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView()
    let usernameLabel = GFTitleLabel(textAlignment: .center)
    let nameLabel = GFSecondaryTitleLabel(textAlignment: .center)
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    let bioBackgroundView = UIView()
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
    }
    
    override func viewDidLayoutSubviews() {
        preferredContentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    

    func configureViewController() {
        
    }
    
    
    func layoutUI() {
        view.addSubview(avatarImageView)
        avatarImageView.downloadAvatar(from: user.avatarUrl)
        
        view.addSubview(usernameLabel)
        usernameLabel.text = user.login
        
        view.addSubview(nameLabel)
        nameLabel.text = user.name ?? ""
        
        view.addSubview(bioBackgroundView)
        bioBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bioBackgroundView.backgroundColor = .secondarySystemBackground
        bioBackgroundView.layer.cornerRadius = 18
        
        bioBackgroundView.addSubview(bioLabel)
        
        view.addSubview(dateLabel)
        dateLabel.textColor = .secondaryLabel
        dateLabel.text = "on GitHub since: \(user.createdAt.convertToDisplayFormat())"
        
        if let _ = user.bio {
            bioLabel.text = user.bio
        } else {
            bioLabel.font = .italicSystemFont(ofSize: 16)
            bioLabel.text = "No bio available"
            bioLabel.textColor = .secondaryLabel
        }
        
        bioLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioBackgroundView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            bioBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: bioBackgroundView.topAnchor, constant: 20),
            bioLabel.leadingAnchor.constraint(equalTo: bioBackgroundView.leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: bioBackgroundView.trailingAnchor, constant: -20),
            bioLabel.bottomAnchor.constraint(equalTo: bioBackgroundView.bottomAnchor, constant: -20)
        ])
    }
    
}
