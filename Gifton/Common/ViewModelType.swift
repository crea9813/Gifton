//
//  ViewModelType.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/05.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
