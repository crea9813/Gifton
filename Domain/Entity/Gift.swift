//
//  Gift.swift
//  Domain
//
//  Created by SuperMove on 2023/01/09.
//

import Foundation

public struct Gift: Codable {
    public let thumbnailImageURL: String
    public let brandName, productName, productDetail: String
    public let price: Double
    public let category: GiftCategory
    
    public init(thumbnailImageURL: String,
                brandName: String,
                productName: String,
                price: Double,
                productDetail: String,
                category: GiftCategory) {
        self.thumbnailImageURL = thumbnailImageURL
        self.brandName = brandName
        self.productName = productName
        self.price = price
        self.productDetail = productDetail
        self.category = category
    }
}

public enum GiftCategory: String, Codable {
    case coffee
    case bakery
    case dessert
    case book
    case unknown
    
    public init(category: String) {
        switch category {
        case "coffee": self = .coffee
        case "bakery": self = .bakery
        case "dessert": self = .dessert
        default: self = .unknown
        }
    }
}
