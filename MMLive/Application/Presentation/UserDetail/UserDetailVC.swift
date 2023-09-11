//
//  UserDetailVC.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import UIKit

class UserDetailVC: BaseVC {
    // MARK: USER IBOutlets (If needed)

    // MARK: -

    @IBOutlet var usernameLBL: UILabel!
    @IBOutlet var userAvatarImageView: UIImageView!

    // MARK: -

    // MARK: - IBOutletCollections (If needed)

    // MARK: -

    //        @IBOutlet var fooButtonCollection: [UIButton]!

    // MARK: -

    // MARK: Public variable

    // MARK: -

    //        public let foo: String = ""

    // MARK: -

    // MARK: Private variable

    // MARK: -

    private let viewModel: UserDetailViewModelProtocol

    // MARK: -

    // MARK: View Lifecycle (If needed)

    // MARK: -

    init(viewModel: UserDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        usernameLBL.text = viewModel.user.username
        userAvatarImageView.setImage(viewModel.user.userAvatar)
    }

    // MARK: -

    // MARK: USER IBActions (If needed)

    // MARK: -

    @IBAction func onBtnOpenUserGitHubProfileAction(_: Any?) {
        guard let userGitHubUrl = viewModel.user.userGitHubURL else { return }

        let alertVC = UIAlertController(
            title: "You will open new app",
            message: "Are you sure want to open this \(userGitHubUrl) link?",
            preferredStyle: .alert
        )

        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Open", style: .default, handler: { [weak self] _ in
            self?.viewModel.openUserGitHubProfile()
        }))

        present(alertVC, animated: true)
    }
}

extension UserDetailVC: UserDetailViewProtocol {}
