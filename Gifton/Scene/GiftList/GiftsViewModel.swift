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
        
        let keyword: Driver<String>
        
        let didSelectGift: Driver<GiftItemViewModel>
    }
    
    struct Output {
        let categories: Driver<[GiftCategoryItemViewModel]>
        
        let gifts: Driver<[GiftItemViewModel]>
        
        let selectGift: Driver<Gift>
        
        let fetching: Driver<Bool>
        
        let error: Driver<GiftError>
    }
    
    private let useCase: GiftsUseCase
    private let coordinator: GiftsCoordinator
    
    init(useCase: GiftsUseCase,
         coordinator: GiftsCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
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
        
        let keywordGifts = Driver.combineLatest(input.keyword, gifts)
            .map { keyword, gifts in
                if keyword.isEmpty { return gifts }
                
                return gifts.filter {
                    $0.brandName.contains(keyword.lowercased()) || $0.productName.contains(keyword.lowercased()) || $0.gift.category.rawValue.contains(keyword.lowercased())
                }
            }
        
        let giftItems = Driver.merge(gifts, keywordGifts)
        
        let selectGift = input.didSelectGift
            .map { $0.gift }
            .do(onNext: coordinator.showGift)
        
        return Output(categories: categories,
                      gifts: giftItems,
                      selectGift: selectGift,
                      fetching: fetching,
                      error: errors)
    }
}
