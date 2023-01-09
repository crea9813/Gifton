//
//  SearchField.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/04.
//

import UIKit
import SnapKit

final class SearchField: UITextField {
    
    private let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        self.attributedPlaceholder = NSAttributedString(string: "Search Store or Items", attributes: [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor(red: 0.698, green: 0.698, blue: 0.698, alpha: 1)])
        self.layer.cornerRadius = 15
        
        self.backgroundColor = UIColor(hex: "E9E9EC")
        self.textColor = UIColor(hex: "939393")
        
        self.addLeftPadding(38)
        self.addRightPadding(10)
        
        self.addSubview(icon)
        
        icon.image = UIImage(named: "magnifyingglass")
        
        icon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


extension UITextField {
    func addLeftPadding(_ inset: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addRightPadding(_ inset: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}

extension UIColor {
    convenience init(hex: String) {
        let cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
