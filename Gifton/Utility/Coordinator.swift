//
//  Coordinator.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import UIKit
import Domain

protocol Coordinator {
    var navigationController: UINavigationController { get }
    var container: UseCaseProvider { get }
}
