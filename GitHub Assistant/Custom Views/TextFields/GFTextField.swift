//
//  GFTextField.swift
//  GitHub
//
//  Created by Adam Paluszewski on 12/09/2022.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 1
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = Fonts.secondaryTitle
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        autocapitalizationType = .none
        
        placeholder = "Type username"
        
        returnKeyType = .search
        keyboardType = .default
        clearButtonMode = .whileEditing
    }
    
}
