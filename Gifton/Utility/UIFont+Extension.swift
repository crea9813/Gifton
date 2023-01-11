//
//  UIFont+Extension.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import Foundation
import UIKit

extension UIFont {
    public class func montFont(ofSize: CGFloat, weight: Weight) -> UIFont {
        var font: UIFont?
        switch weight {
        case .regular: font = UIFont(name: "MontserratAlternates-Regular", size: ofSize)
        case .thin: font = UIFont(name: "MontserratAlternates-Thin", size: ofSize)
        case .ultraLight: font = UIFont(name: "MontserratAlternates-ExtraLight", size: ofSize)
        case .medium: font = UIFont(name: "MontserratAlternates-Medium", size: ofSize)
        case .semibold: font = UIFont(name: "MontserratAlternates-SemiBold", size: ofSize)
        case .bold: font = UIFont(name: "MontserratAlternates-Bold", size: ofSize)
        case .heavy: font = UIFont(name: "MontserratAlternates-ExtraBold", size: ofSize)
        case .black: font = UIFont(name: "MontserratAlternates-Black", size: ofSize)
        default: font = .systemFont(ofSize: ofSize, weight: weight)
        }
        return font ?? .systemFont(ofSize: ofSize, weight: weight)
    }
}
