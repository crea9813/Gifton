//
//  GiftsViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/05.
//

import RxSwift
import RxCocoa

final class GiftsViewModel: ViewModelType {
 
    struct Input {
        
    }
    
    struct Output {
        let categories: Driver<[GiftCategoryItemViewModel]>
    }
    
//    private let useC
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        
        let categories = Driver<[GiftCategoryItemViewModel]>
            .just([GiftCategoryItemViewModel(with: "coffee"),
                  GiftCategoryItemViewModel(with: "bakery"),
                  GiftCategoryItemViewModel(with: "books"),
                  GiftCategoryItemViewModel(with: "movie")])
        
        return Output(categories: categories)
    }
}
