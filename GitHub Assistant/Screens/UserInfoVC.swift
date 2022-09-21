//
//  UserInfoVC.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit
import SafariServices

class UserInfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    var addButton = UIBarButtonItem()
    
    var username: String!
    var user: User!
    
    var isInFavorites = false {
        didSet {
            switch isInFavorites {
                case true:
                    addButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(addButtonTapped))
                case false:
                    addButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addButtonTapped))
            }
            navigationItem.rightBarButtonItem = addButton
        }
    }
    
    
    init(username: String!) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        fetchUser()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = false
        checkIfUserIsInFavorites()
    }
    
    
    func fetchUser() {
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.user = user
                        self.configureUIElements(with: user)
                        self.checkIfUserIsInFavorites()
                    }
                case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: SFSymbols.error)
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        let followerItemVC = GFFollowerItemVC(user: user)
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    func configureViewController() {
        navigationItem.title = "Profile"
        view.backgroundColor = .systemBackground
    }
    
    
    func checkIfUserIsInFavorites() {
        PersistenceManager.shared.retrieveFavorites { result in
            switch result {
                case .success(let followers):
                    isInFavorites = !followers.filter({$0.login == username}).isEmpty ? true : false
                case .failure(let error):
                    print(error.rawValue)
            }
        }
    }
    
    
    @objc func addButtonTapped() {
        switch isInFavorites {
            case true:
                removeUserFromFavorites(user: user)
            case false:
                addUserToFavorites(user: user)
                
        }
        
    }
    
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.shared.updateWith(favorite: favorite, actionType: .add) { error in
            if let _ = error {
                self.presentGFAlert(title: "Something went wrong", message: "You already have this user in favorites.", buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: SFSymbols.error)
            }
            else {
                self.isInFavorites = true
                self.addButton.image = UIImage(systemName: "heart.fill")
                self.presentGFAlert(title: "Success!", message: "User added", buttonTitle: "OK", buttonColor: .systemGreen, buttonSystemImage: SFSymbols.success)
            }
        }
    }
    
    
    func removeUserFromFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.shared.updateWith(favorite: favorite, actionType: .remove) { error in
            if let _ = error {
                self.presentGFAlert(title: "Something went wrong", message: "Error", buttonTitle: "OK", buttonColor: .systemRed, buttonSystemImage: SFSymbols.error)
            }
            else {
                self.isInFavorites = false
                self.addButton.image = UIImage(systemName: "heart")
                self.presentGFAlert(title: "Success!", message: "User removed", buttonTitle: "OK", buttonColor: .systemGreen, buttonSystemImage: SFSymbols.success)
            }
        }
    }
    
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        if container as? GFUserInfoHeaderVC  != nil {
            let newHeight = container.preferredContentSize.height
            headerView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        }
    }
    
    
    func layoutUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(itemViewOne)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            itemViewTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
