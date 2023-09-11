//
//  UsersListVC.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import UIKit

class UsersListVC: BaseVC {
    // MARK: USER IBOutlets (If needed)

    // MARK: -

    @IBOutlet var tableView: UITableView!

    // MARK: -

    // MARK: Public variable

    // MARK: -

    //        public let foo: String = ""

    // MARK: -

    // MARK: Private variable

    // MARK: -

    private let viewModel: UsersListViewModelProtocol

    // MARK: -

    // MARK: View Lifecycle (If needed)

    // MARK: -

    init(viewModel: UsersListViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        registerCells()

        viewModel.loadData()
    }

    // MARK: -

    // MARK: USER IBActions (If needed)

    // MARK: -

    //        @IBAction func fooUserShowModalAction(_ sender : Any?) {
    //
    //        }

    // MARK: -

    // MARK: ADDITIONAL PUBLIC HELPERS

    // MARK: -

    //        public func displayName(foo _: Any?) {
    //
    //        }

    // MARK: -

    // MARK: ADDITIONAL PRIVATE HELPERS

    // MARK: -

    private func registerCells() {
        UserTCell.register(tableView)
    }
}

extension UsersListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTCell.identifier, for: indexPath) as? UserTCell else { fatalError() }
        cell.configure(viewModel.list[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openUserDetailScreen(indexPath)
    }
}

extension UsersListVC: UsersListViewProtocol {
    func showIndicator(show: Bool) {
        startActivityIndicator(show)
    }

    func reloadData() {
        tableView.reloadData()
    }
}
