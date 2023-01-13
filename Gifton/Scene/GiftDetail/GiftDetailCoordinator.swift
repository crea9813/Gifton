//
//  GiftDetailCoordinator.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import UIKit
import Domain

protocol GiftDetailCoordinator: Coordinator {
    func toCreateCard(gift: Gift, contact: String)
}

class DefaultGiftDetailCoordinator: GiftDetailCoordinator {
    
    var navigationController: UINavigationController
    
    var container: Domain.UseCaseProvider
    
    init(navigationController: UINavigationController,
         container: Domain.UseCaseProvider) {
        self.navigationController = navigationController
        self.container = container
    }

    func toCreateCard(gift: Gift, contact: String) {
        let coordinator = DefaultGiftCardCoordinator(navigationController: navigationController, container: container)
        let viewModel = GiftCardViewModel(gift: gift,
                                          contact: contact,
                                          useCase: container.makeGiftsUseCase(),
                                          coordinator: coordinator)
        let view = GiftCardViewController.create(with: viewModel)
        navigationController.pushViewController(view, animated: true)
    }
}
