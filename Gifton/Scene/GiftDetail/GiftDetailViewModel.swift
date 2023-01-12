//
//  GiftDetailViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import Domain
import RxSwift
import RxCocoa
import Contacts

final class GiftDetailViewModel: ViewModelType {
    
    struct Input {
        let didSendGift: Driver<CNContact>
    }
    
    struct Output {
        let gift: Driver<Gift>
        
        let sendGift: Driver<CNContact>
        
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
        
        let didSendGift = input.didSendGift
            .do(onNext: {
                print($0)
            })
        
        return Output(gift: gift,
                      sendGift: didSendGift,
                      fetching: fetching,
                      error: errors)
    }
}
