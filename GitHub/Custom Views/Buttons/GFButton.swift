//
//  GFButton.swift
//  GitHub
//
//  Created by Adam Paluszewski on 12/09/2022.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String, backgroundColor: UIColor, systemImage: UIImage) {
        super.init(frame: .zero)
        configure()
        self.set(title: title, backgroundColor: backgroundColor, systemImage: systemImage)
    }
    
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        configuration?.title = "OK"
        configuration?.baseForegroundColor = .white
        configuration?.imagePlacement = .leading
        configuration?.imagePadding = 5

        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = Fonts.buttonTitle
            return outgoing
         }
    }
    
    
    func set(title: String, backgroundColor: UIColor, systemImage: UIImage) {
        configuration?.title = title
        configuration?.baseBackgroundColor = backgroundColor
        configuration?.image = systemImage
    }
}
