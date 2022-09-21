//
//  RepositoriesCell.swift
//  GitHub
//
//  Created by Adam Paluszewski on 16/09/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {

    static let cellId = "RepositoriesCell"
    
    let nameLabel = GFSecondaryTitleLabel(textAlignment: .left)
    let languageLabel = GFBodyLabel(textAlignment: .left)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(repo: Repos) {
        nameLabel.text = repo.name
        languageLabel.text = repo.language ?? "-"
    }
    
    
    func configure() {
        accessoryType = .disclosureIndicator
        
        addSubview(nameLabel)
        nameLabel.textColor = .label
        
        addSubview(languageLabel)
        languageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            languageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
}
