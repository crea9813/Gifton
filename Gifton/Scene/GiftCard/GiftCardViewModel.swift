//
//  GiftCardViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/12.
//

import Domain
import RxSwift
import RxCocoa

final class GiftCardViewModel: ViewModelType {
 
    struct Input {
        let didSendGift: Driver<Void>
    }
    
    struct Output {
        let cards: Driver<[GiftCardItemViewModel]>
        
        let sendGift: Driver<Void>
        
        let fetching: Driver<Bool>
        
        let error: Driver<GiftError>
    }
    
    private let useCase: GiftsUseCase
    private let coordinator: GiftCardCoordinator
    
    init(useCase: GiftsUseCase,
         coordinator: GiftCardCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.compactMap({ $0 as? GiftError }).asDriver()
        
        let cards = Driver<[GiftCardItemViewModel]>
            .just([GiftCardItemViewModel(with: "gift_card_1"),
                   GiftCardItemViewModel(with: "gift_card_2"),
                   GiftCardItemViewModel(with: "gift_card_3")
                  ])
        
        let didSendGift = input.didSendGift
            .do(onNext: coordinator.toConfirmOrder)
        
        return Output(cards: cards,
                      sendGift: didSendGift,
                      fetching: fetching,
                      error: errors)
    }
}

