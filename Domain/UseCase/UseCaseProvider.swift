//
//  UseCaseProvider.swift
//  Domain
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation

public protocol UseCaseProvider {

    func makeGiftsUseCase() -> GiftsUseCase
    
}
