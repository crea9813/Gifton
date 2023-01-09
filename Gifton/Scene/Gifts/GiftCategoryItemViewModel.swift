//
//  GiftItemViewModel.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/05.
//

import Foundation
import Domain

final class GiftCategoryItemViewModel {
    let title: String
    let iconNamed: String
    
    init(with title: String) {
        self.title = title.capitalizedSentence
        self.iconNamed = "ic_\(title)"
    }
}

extension String {
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}
