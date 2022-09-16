//
//  SearchVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 12/09/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(title: "Search", backgroundColor: .systemGreen, systemImage: SFSymbols.search)

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
        let followersListVC = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followersListVC, animated: true)
        usernameTextField.resignFirstResponder()
    }
   
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
