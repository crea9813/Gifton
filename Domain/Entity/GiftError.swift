//
//  GiftError.swift
//  Domain
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation

public enum GiftError: Error {
    case apiKeyExpired
    case emptyData
    case decodingFailed
    case unknown
    case with(message: String)
    
    public init(message: String) {
        switch message {
        case "api_key_expired": self = .apiKeyExpired
        case "empty_data": self = .emptyData
        case "decoding_failed": self = .decodingFailed
        default: self = message.isEmpty ? .unknown : .with(message: message)
        }
    }
}

