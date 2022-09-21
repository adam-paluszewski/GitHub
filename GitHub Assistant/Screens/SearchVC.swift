//
//  SearchVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 12/09/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(title: "Search", backgroundColor: .systemIndigo, systemImage: SFSymbols.search)
    let infoLabel = GFCaptionLabel(textAlignment: .center)
    let settingsButton = GFSettingsButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createDismissKeyboardTapGesture()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        usernameTextField.text = ""
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowersListVC() {
        guard !usernameTextField.text!.isEmpty else {
            presentGFAlert(title: "No results", message: "Please type something before searching", buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: SFSymbols.error)
            return
        }

        let userInfoVC = UserInfoVC(username: usernameTextField.text)
        navigationController?.pushViewController(userInfoVC, animated: true)
        usernameTextField.resignFirstResponder()
    }
    
    
    func configureViewController() {
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        let topColor = UIColor(named: "top-color")!.cgColor
        let midColor = UIColor(named: "mid-color")!.cgColor
        let bottomColor = UIColor(named: "bottom-color")!.cgColor
        gradientLayer.colors = [topColor, midColor, bottomColor]
        
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        view.addSubview(infoLabel)
        infoLabel.numberOfLines = 0
        infoLabel.text = "This app is not official GitHub app. It's third party product using public GitHub API and logos according to GitHub license: https://github.com/logos."
        
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            callToActionButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 44),
            
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //gradient layer updates when chaning system color theme
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        let topColor = UIColor(named: "top-color")!.cgColor
        let midColor = UIColor(named: "mid-color")!.cgColor
        let bottomColor = UIColor(named: "bottom-color")!.cgColor
        gradientLayer.colors = [topColor, midColor, bottomColor]
    }

}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
