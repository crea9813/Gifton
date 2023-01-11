//
//  GiftsUseCase.swift
//  Domain
//
//  Created by SuperMove on 2023/01/10.
//

import Foundation
import RxSwift

public protocol GiftsUseCase {
    func gifts() -> Single<[Gift]>
}
