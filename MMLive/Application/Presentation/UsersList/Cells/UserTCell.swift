//
//  UserTCell.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import UIKit

class UserTCell: BaseTCell {
    // MARK: -

    // MARK: IBOutles

    // MARK: -

    @IBOutlet var usernameLBL: UILabel!
    @IBOutlet var githubUrlLBL: UILabel!

    // MARK: -

    // MARK: Configuration

    // MARK: -

    func configure(_ model: UserML) {
        usernameLBL.text = model.username
        githubUrlLBL.text = model.userGitHubURL
    }
}
