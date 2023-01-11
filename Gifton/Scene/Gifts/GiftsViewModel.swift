//
//  GiftsViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/05.
//

import Domain
import RxSwift
import RxCocoa

final class GiftsViewModel: ViewModelType {
 
    struct Input {
        let loadGifts: Driver<Void>
    }
    
    struct Output {
        let categories: Driver<[GiftCategoryItemViewModel]>
        
        let gifts: Driver<[GiftItemViewModel]>
        
        let fetching: Driver<Bool>
        
        let error: Driver<GiftError>
    }
    
    private let useCase: GiftsUseCase
    
    init(useCase: GiftsUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.compactMap({ $0 as? GiftError }).asDriver()
        
        let categories = Driver<[GiftCategoryItemViewModel]>
            .just([GiftCategoryItemViewModel(with: "coffee"),
                  GiftCategoryItemViewModel(with: "bakery"),
                  GiftCategoryItemViewModel(with: "books"),
                  GiftCategoryItemViewModel(with: "movie")])
        
        let gifts = input.loadGifts.flatMapLatest {
            [unowned self] in
            return self.useCase.gifts()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { GiftItemViewModel(with: $0) } }
        }
        
        return Output(categories: categories,
                      gifts: gifts,
                      fetching: fetching,
                      error: errors)
    }
}
