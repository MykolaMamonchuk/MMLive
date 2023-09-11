//
//  BaseTCell.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import UIKit

class BaseTCell: UITableViewCell {
    class var className: String {
        String(describing: self)
    }

    class var identifier: String {
        String(describing: self)
    }

    class func register(_ tableView: UITableView) {
        let nib = UINib(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}
