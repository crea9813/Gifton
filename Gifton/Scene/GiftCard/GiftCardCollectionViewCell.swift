//
//  GiftCardCollectionViewCell.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/12.
//

import UIKit

final class GiftCardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GiftCardCollectionViewCell"
    
    private let cardImageView = UIImageView()
        .then {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }
    
    func bind(with viewModel: GiftCardItemViewModel) {
        self.cardImageView.image = UIImage(named: "\(viewModel.cardImageNamed)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8
        
        self.addSubview(cardImageView)
        
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
