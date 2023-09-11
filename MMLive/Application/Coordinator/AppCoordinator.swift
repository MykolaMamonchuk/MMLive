//
//  AppCoordinator.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Foundation
import UIKit

class AppCoordinator: RootCoordinator {
    // MARK: -

    // MARK: Public variables

    // MARK: -

    var window: UIWindow
    var rootViewController: UINavigationController = .init() {
        didSet {
            window.rootViewController = rootViewController
        }
    }

    init(_ window: UIWindow) {
        self.window = window
    }

    // MARK: -

    // MARK: Public methods

    // MARK: -

    func start() {
        rootViewController = UINavigationController(rootViewController: buildUsersListScreen())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func openUserDetailScreenBy(_ user: UserML) {
        rootViewController.pushViewController(buildUsersDetailScreen(user), animated: true)
    }

    // MARK: -

    // MARK: Private methods

    // MARK: -

    private func buildUsersListScreen() -> UIViewController {
        let viewModel = UsersListViewModel(coordinator: self)
        let vc = UsersListVC(viewModel: viewModel)
        viewModel.viewDelegate = vc
        return vc
    }

    private func buildUsersDetailScreen(_ user: UserML) -> UIViewController {
        let viewModel = UserDetailViewModel(user: user, coordinator: self)
        let vc = UserDetailVC(viewModel: viewModel)
        viewModel.viewDelegate = vc
        return vc
    }
}
