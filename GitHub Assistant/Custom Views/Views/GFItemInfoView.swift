//
//  GFItemInfoView.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbolImageView = GFGenericImageView(frame: .zero)
    let titleLabel = GFBodyLabel(textAlignment: .left)
    let countLabel = GFBodyLabel(textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(itemInfoType: ItemInfoType, count: Int) {
        switch itemInfoType {
            case .repos:
                symbolImageView.image = SFSymbols.repos
                titleLabel.text = "Public repos"
            case .gists:
                symbolImageView.image = SFSymbols.gists
                titleLabel.text = "Public gists"
            case .followers:
                symbolImageView.image = SFSymbols.followers
                titleLabel.text = "Followers"
            case .following:
                symbolImageView.image = SFSymbols.following
                titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        addSubview(titleLabel)
        
        
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
