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
}
