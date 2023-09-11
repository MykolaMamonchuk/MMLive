//
//  ExtUIImageView.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(_ urlString: String?, _ placeholder: UIImage? = nil) {
        guard let urlString = urlString, let imgURL = URL(string: urlString) else { return }
        kf.setImage(with: imgURL, placeholder: placeholder, options: [.transition(.fade(0.25))])
    }
}
