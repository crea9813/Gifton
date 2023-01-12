//
//  GiftDetailCoordinator.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import UIKit
import Domain

protocol GiftDetailCoordinator: Coordinator {
    func showContact()
    func toCreateCard()
}

class DefaultGiftDetailCoordinator: GiftDetailCoordinator {
    
    var navigationController: UINavigationController
    
    var container: Domain.UseCaseProvider
    
    init(navigationController: UINavigationController,
         container: Domain.UseCaseProvider) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func showContact() {
        let view = ContactPickerViewController()
        navigationController.present(view, animated: true)
    }
    
    func toCreateCard() {
        
    }
}
