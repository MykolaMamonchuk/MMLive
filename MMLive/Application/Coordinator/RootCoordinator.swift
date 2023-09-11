//
//  RootCoordinator.swift
//  MMLive
//
//  Created by MMU on 11.09.2023.
//

import Foundation
import UIKit

protocol RootCoordinator: AnyObject {
    var rootViewController: UINavigationController { get }
    func start()
}
