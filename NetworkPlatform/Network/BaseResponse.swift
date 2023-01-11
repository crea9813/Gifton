//
//  BaseResponse.swift
//  NetworkPlatform
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation

struct BaseResponse<T : Decodable>: Decodable {
    var error: ErrorResponse?
    var response: T?
}

struct ErrorResponse: Decodable, LocalizedError {
    let message, code: String
}
