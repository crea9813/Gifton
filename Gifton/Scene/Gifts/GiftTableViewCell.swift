//
//  GiftTableViewCell.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/09.
//

import UIKit

final class GiftTableViewCell: UITableViewCell {
    static let reuseIdentifier = "GiftTableViewCell"
    
    private let iconWrapView = UIView()
        .then {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
        }
    
    private let iconView = UIImageView()
    
    private let contentWrapView = UIView()
        .then {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
        }
    
    private let brandNameLabel = UILabel()
        .then {
            $0.textColor = UIColor(hex: "66554F")
        }
    
    private let productNameLabel = UILabel()
        .then {
            $0.textColor = UIColor(hex: "66554F")
        }
    
    private let priceLabel = UILabel()
        .then {
            $0.textColor = UIColor(hex: "66554F")
        }
    
    func bind(with viewModel: GiftItemViewModel) {
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(iconWrapView)
        self.addSubview(contentWrapView)
        
        iconWrapView.addSubview(iconView)
        
        contentWrapView.addSubview(brandNameLabel)
        contentWrapView.addSubview(productNameLabel)
        contentWrapView.addSubview(priceLabel)
        
        iconWrapView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.width.height.equalTo(70)
            $0.leading.trailing.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(iconWrapView.snp.bottom).inset(8)
        }
        
        brandNameLabel.snp.makeConstraints {
            $0.top.equalTo(iconWrapView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

