//
//  GiftsUseCase.swift
//  NetworkPlatform
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation
import Domain
import RxSwift

final class GiftsUseCase: Domain.GiftsUseCase {
//    private let service: Network<GiftAPI>
    
    func gifts() -> Single<[Gift]> {
        return Single.just([
            Gift(thumbnailImageURL: "", brandName: "Midnight Mug", productName: "Iced Coffee", price: 2.85),
            Gift(thumbnailImageURL: "", brandName: "Midnight Mug", productName: "Hot Coffee", price: 2.50),
            Gift(thumbnailImageURL: "", brandName: "Midnight Mug", productName: "Iced Tea", price: 2.85),
            Gift(thumbnailImageURL: "", brandName: "Grounded", productName: "Iced Americano", price: 3.25),
            Gift(thumbnailImageURL: "", brandName: "Grounded", productName: "Hot Americano", price: 3.05),
            Gift(thumbnailImageURL: "", brandName: "Grounded", productName: "Iced Latte", price: 3.95),
            Gift(thumbnailImageURL: "", brandName: "More Uncommon Grounds", productName: "Macchiato", price: 3.50),
            Gift(thumbnailImageURL: "", brandName: "More Uncommon Grounds", productName: "Rainbow Fish", price: 2.95),
            Gift(thumbnailImageURL: "", brandName: "More Uncommon Grounds", productName: "Robin Hood", price: 3.75),
            Gift(thumbnailImageURL: "", brandName: "Midnight Mug", productName: "Half & Half", price: 2.85),
        ])
    }
    
}
