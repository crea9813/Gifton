//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    public init() { }
    
    public func makeGiftsUseCase() -> Domain.GiftsUseCase {
        return GiftsUseCase()
    }
    
}
