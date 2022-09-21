//
//  GFSettingsButton.swift
//  GitHub Assistant
//
//  Created by Adam Paluszewski on 18/09/2022.
//

import UIKit

class GFSettingsButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = .filled()
        configuration?.cornerStyle = .capsule
        configuration?.baseForegroundColor = .systemIndigo
        configuration?.baseBackgroundColor = .clear
        configuration?.imagePlacement = .all
        configuration?.image = UIImage(systemName: "sun.max.fill")
        configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 25)
        
        showsMenuAsPrimaryAction = true
        changesSelectionAsPrimaryAction = false
        
        let light = UIAction(title: "Light", image: UIImage(systemName: "lightbulb.fill"), state: .off) { action in
            UIView.transition (with: self.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window!.overrideUserInterfaceStyle = .light
            }, completion: nil)
            UserDefaults.standard.set(true, forKey: "isUserIntefaceLight")
        }
        
        let dark = UIAction(title: "Dark", image: UIImage(systemName: "lightbulb"), state: .off) { action in
            UIView.transition (with: self.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window!.overrideUserInterfaceStyle = .dark
            }, completion: nil)
            UserDefaults.standard.set(false, forKey: "isUserIntefaceLight")
        }
        
        let system = UIAction(title: "System", image: UIImage(systemName: "gear"), state: .off) { action in
            UIView.transition (with: self.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window!.overrideUserInterfaceStyle = .unspecified
            }, completion: nil)
            UserDefaults.standard.set(nil, forKey: "isUserIntefaceLight")
        }
        
        let themes = [light, dark, system]
        let themesMenu = UIMenu(title: "Choose theme", children: themes)
        menu = themesMenu
    }
}
