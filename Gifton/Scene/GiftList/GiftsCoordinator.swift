//
//  GiftsNavigator.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/10.
//

import UIKit
import Domain

protocol GiftsCoordinator: Coordinator {
    func showGift(_ gift: Gift)
    func showGifts()
}

class DefaultGiftsCoordinator: GiftsCoordinator {
    
    var navigationController: UINavigationController
    
    var container: Domain.UseCaseProvider
    
    init(navigationController: UINavigationController,
         container: Domain.UseCaseProvider) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func showGift(_ gift: Domain.Gift) {
        let coordinator = DefaultGiftDetailCoordinator(navigationController: navigationController, container: container)
        let viewModel = GiftDetailViewModel(gift: gift,
                                            useCase: container.makeGiftsUseCase(),
                                            coordinator: coordinator)
        let view = GiftDetailViewController.create(with: viewModel)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showGifts() {
        let viewModel = GiftsViewModel(useCase: container.makeGiftsUseCase(),
                                       coordinator: self)
        let view = GiftsViewController.create(with: viewModel)
        navigationController.pushViewController(view, animated: true)
    }
}
