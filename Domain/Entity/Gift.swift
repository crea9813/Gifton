//
//  Gift.swift
//  Domain
//
//  Created by SuperMove on 2023/01/09.
//

import Foundation

public struct Gift: Codable {
    public let thumbnailImageURL: String
    public let brandName, productName: String
    public let price: Double
    
    public init(thumbnailImageURL: String,
                brandName: String,
                productName: String,
                price: Double) {
        self.thumbnailImageURL = thumbnailImageURL
        self.brandName = brandName
        self.productName = productName
        self.price = price
    }
}
