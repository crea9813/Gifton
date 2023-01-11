//
//  PaddingButton.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import Foundation
import UIKit

final class PaddingButton: UIButton {
    
    private let inset: UIEdgeInsets
    
    required init(_ inset: UIEdgeInsets) {
        self.inset = inset
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += inset.top + inset.bottom
            contentSize.width += inset.left + inset.right + abs(self.titleEdgeInsets.left) + abs(self.titleEdgeInsets.right) + abs(self.imageEdgeInsets.left) + abs(self.imageEdgeInsets.right)
            return contentSize
        }
    }
    
}
