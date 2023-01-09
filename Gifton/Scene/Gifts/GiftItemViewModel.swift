//
//  GiftItemViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/09.
//

import Foundation
import Domain

final class GiftItemViewModel {
    let thumbnailImage: String
    let brandName: String
    let productName: String
    let price: Double
    
    init(with gift: Gift) {
        self.thumbnailImage = ""
        self.brandName = ""
        self.productName = ""
        self.price = 0
    }
}
