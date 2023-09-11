//
//  BaseVC.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import NVActivityIndicatorView
import UIKit

class BaseVC: UIViewController {
    init(nibName nib: String? = nil) {
        super.init(nibName: nib, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private(set) lazy var indicator: NVActivityIndicatorView = getIndicator()

    // MARK: -

    // MARK: Public functions

    // MARK: -

    func startActivityIndicator(_ show: Bool) {
        if show {
            if indicator.superview != nil { return }
            view.addSubview(indicator)
            indicator.startAnimating()
        } else if !show {
            indicator.startAnimating()
            indicator.removeFromSuperview()
        }
    }

    // MARK: -

    // MARK: Private functions

    // MARK: -

    private func getIndicator() -> NVActivityIndicatorView {
        return NVActivityIndicatorView(
            frame: UIScreen.main.bounds,
            type: .ballBeat,
            color: .red,
            padding: 150.0
        )
    }
}
