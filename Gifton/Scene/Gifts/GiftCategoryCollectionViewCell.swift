//
//  GiftCategoryCollectionViewCell.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/05.
//

import UIKit

final class GiftCategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GiftCategoryCollectionViewCell"
    
    private let iconWrapView = UIView()
        .then {
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(hex: "D6D5D5").cgColor
        }
    
    private let iconView = UIImageView()
    
    private let titleLabel = UILabel()
        .then {
            $0.textColor = UIColor(hex: "66554F")
            $0.textAlignment = .center
        }
    
    func bind(with viewModel: GiftCategoryItemViewModel) {
        self.titleLabel.text = viewModel.title
        self.iconView.image = UIImage(named: viewModel.iconNamed)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(iconWrapView)
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        
        
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
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconWrapView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
