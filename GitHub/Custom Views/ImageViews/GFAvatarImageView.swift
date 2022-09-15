//
//  GFAvatarImageView.swift
//  GitHub
//
//  Created by Adam Paluszewski on 13/09/2022.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeholder = Images.placeholder
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func downloadAvatar(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
