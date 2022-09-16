//
//  GFConstants.swift
//  GitHub
//
//  Created by Adam Paluszewski on 14/09/2022.
//

import UIKit


enum SFSymbols{
    static let location = UIImage(systemName: "mappin.and.ellipse")!
    static let repos = UIImage(systemName: "folder")!
    static let gists = UIImage(systemName: "text.alignleft")!
    static let followers = UIImage(systemName: "heart")!
    static let following = UIImage(systemName: "person.2")!
    static let error = UIImage(systemName: "x.circle")!
    static let success = UIImage(systemName: "checkmark.circle")!
    static let search = UIImage(systemName: "magnifyingglass.circle.fill")!
    static let person = UIImage(systemName: "person")!
    static let person2 = UIImage(systemName: "person.2")!
}


enum Images {
    static let ghLogo = UIImage(named: "gh-logo")!
    static let placeholder = UIImage(named: "avatar-placeholder")!
    static let emptyState = UIImage(named: "empty-state-logo")!
}

enum Fonts {
    static let body = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let title = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let buttonTitle = UIFont.systemFont(ofSize: 16, weight: .medium)
}
