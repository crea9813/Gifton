//
//  GiftItemViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/09.
//

import Foundation
import Domain

final class GiftItemViewModel {
    
    let gift: Gift
    
    let thumbnailImage: String
    let brandName: String
    let productName: String
    let price: Double
    
    init(with gift: Gift) {
        self.gift = gift
        
        self.thumbnailImage = gift.thumbnailImageURL
        self.brandName = gift.brandName
        self.productName = gift.productName
        self.price = gift.price
    }
}
