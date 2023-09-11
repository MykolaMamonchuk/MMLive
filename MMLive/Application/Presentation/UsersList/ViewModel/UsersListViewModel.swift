//
//  UsersListViewModel.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Foundation

protocol UsersListViewProtocol: AnyObject {
    func showIndicator(show: Bool)
    func reloadData()
}

protocol UsersListViewModelProtocol: AnyObject {
    var list: [UserML] { get }
    func loadData()
    func openUserDetailScreen(_ indexPath: IndexPath)
}

final class UsersListViewModel: UsersListViewModelProtocol {
    // MARK: -

    // MARK: Properties

    // MARK: -

    var list: [UserML] = .init()
    weak var viewDelegate: UsersListViewProtocol?

    // MARK: -

    // MARK: Private Properties

    // MARK: -

    private weak var coordinator: AppCoordinator?

    // MARK: -

    // MARK: Initializator

    // MARK: -

    init(coordinator: AppCoordinator? = nil) {
        self.coordinator = coordinator
    }

    // MARK: -

    // MARK: ViewModelProtocol Functions

    // MARK: -

    func loadData() {
        viewDelegate?.showIndicator(show: true)
        DispatchQueue.global(qos: .userInitiated).async {
            APIManager.sI.getUsersList { [weak self] response in
                switch response {
                case let .success(result):
                    print("result: \(result.count)")
                    self?.list = result
                case let .failure(error):
                    print("error: \(error.localizedDescription)")
                }

                DispatchQueue.main.async { [weak self] in
                    // Could update UI if needed
                    self?.viewDelegate?.reloadData()
                    self?.viewDelegate?.showIndicator(show: false)
                }
            }
        }
    }

    func openUserDetailScreen(_ indexPath: IndexPath) {
        coordinator?.openUserDetailScreenBy(list[indexPath.row])
    }
}
