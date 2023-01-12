//
//  GiftCardCoordinator.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/12.
//

import UIKit
import Domain

protocol GiftCardCoordinator: Coordinator {
    func toConfirmOrder()
}

class DefaultGiftCardCoordinator: GiftCardCoordinator {
    
    var navigationController: UINavigationController
    
    var container: Domain.UseCaseProvider
    
    init(navigationController: UINavigationController,
         container: Domain.UseCaseProvider) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func toConfirmOrder() {
        
    }
}
