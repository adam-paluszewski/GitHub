//
//  UITableViewExtension.swift
//  GitHub
//
//  Created by Adam Paluszewski on 15/09/2022.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
