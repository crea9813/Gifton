//
//  GiftDetailViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import Domain
import RxSwift
import RxCocoa

final class GiftDetailViewModel: ViewModelType {
    
    struct Input {
        let didSendGift: Driver<String>
    }
    
    struct Output {
        let gift: Driver<Gift>
        
        let sendGift: Driver<(Gift, String)>
        
        let fetching: Driver<Bool>
        
        let error: Driver<GiftError>
    }
    
    private let gift: Gift
    private let useCase: GiftsUseCase
    private let coordinator: GiftDetailCoordinator
    
    init(gift: Gift,
         useCase: GiftsUseCase,
         coordinator: GiftDetailCoordinator) {
        self.gift = gift
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.compactMap({ $0 as? GiftError }).asDriver()
        
        let gift = Driver.just(self.gift)
        
        let giftAndContact = Driver.combineLatest(gift, input.didSendGift)
        
        let didSendGift = input.didSendGift
            .withLatestFrom(giftAndContact)
            .do(onNext: self.coordinator.toCreateCard)
        
        return Output(gift: gift,
                      sendGift: didSendGift,
                      fetching: fetching,
                      error: errors)
    }
}
