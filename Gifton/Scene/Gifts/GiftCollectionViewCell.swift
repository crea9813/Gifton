//
//  GiftTableViewCell.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/09.
//

import UIKit

final class GiftCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GiftCollectionViewCell"
    
    private let iconWrapView = UIView()
        .then {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
        }
    
    private let iconView = UIImageView()
        .then {
            $0.backgroundColor = UIColor(hex: "D9D9D9")
            $0.layer.cornerRadius = 4
        }
    
    private let contentWrapView = UIView()
        .then {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
        }
    
    private let brandNameLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 13, weight: .regular)
            $0.textColor = UIColor(hex: "AEAEB2")
        }
    
    private let productNameLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = UIColor(hex: "66554F")
            $0.numberOfLines = 2
        }
    
    private let priceLabel = UILabel()
        .then {
            $0.font = .systemFont(ofSize: 13, weight: .medium)
            $0.textColor = UIColor(hex: "66554F")
        }
    
    func bind(with viewModel: GiftItemViewModel) {
//        self.iconView
        self.brandNameLabel.text = viewModel.brandName
        self.productNameLabel.text = viewModel.productName
        self.priceLabel.text = "$ \(viewModel.price)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.06
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        self.addSubview(iconWrapView)
        self.addSubview(contentWrapView)
        
        iconWrapView.addSubview(iconView)
        
        contentWrapView.addSubview(brandNameLabel)
        contentWrapView.addSubview(productNameLabel)
        contentWrapView.addSubview(priceLabel)
        
        iconWrapView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(iconWrapView.snp.width)
        }
        
        iconView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        contentWrapView.snp.makeConstraints {
            $0.top.equalTo(iconWrapView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        brandNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(10)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandNameLabel.snp.bottom)
            $0.height.equalTo(33)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hex: "AEAEB2").cgColor
        shapeLayer.lineWidth = 3
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [4, 4]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 8, y: self.bounds.width), CGPoint(x: self.bounds.width - 8, y: self.bounds.width)])
        shapeLayer.path = path
        iconWrapView.layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

