//
//  UserDetailViewModel.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Foundation
import UIKit

protocol UserDetailViewProtocol: AnyObject {}

protocol UserDetailViewModelProtocol: AnyObject {
    var user: UserML { get }
    func openUserGitHubProfile()
}

final class UserDetailViewModel: UserDetailViewModelProtocol {
    // MARK: -

    // MARK: Properties

    // MARK: -

    var user: UserML
    weak var viewDelegate: UserDetailViewProtocol?

    // MARK: -

    // MARK: Private Properties

    // MARK: -

    private weak var coordinator: AppCoordinator?

    // MARK: -

    // MARK: Initializator

    // MARK: -

    init(user: UserML, coordinator: AppCoordinator? = nil) {
        self.user = user
        self.coordinator = coordinator
    }

    // MARK: -

    // MARK: ViewModelProtocol Functions

    // MARK: -

    func openUserGitHubProfile() {
        guard let gutHubUrl = user.userGitHubURL else { print("Show Alert EMPTY URL"); return }
        guard let url = URL(string: gutHubUrl) else { print("Show Alert URL is invalid"); return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Show Alert: Can't open URL")
        }
    }
}
