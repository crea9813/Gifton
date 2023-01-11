//
//  GiftDetailViewController.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/11.
//

import UIKit
import SnapKit
import RxSwift
import ContactsUI

final class GiftDetailViewController: UIViewController {
    
    static func create(with viewModel: GiftDetailViewModel) -> GiftDetailViewController {
        let view = GiftDetailViewController()
        view.viewModel = viewModel
        return view
    }
    
    private var viewModel: GiftDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    private var statusBar: UIView!
    
    private let productImageView = UIImageView()
        .then {
            $0.backgroundColor = UIColor(hex: "D9D9D9")
        }
    
    private let scrollView = UIScrollView()
        .then {
            $0.contentInsetAdjustmentBehavior = .never
        }
    
    private let productInfoView = UIView()
        .then {
            $0.layer.cornerRadius = 20
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.06
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    
    private let productNameLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 22, weight: .semibold)
            $0.textColor = UIColor(hex: "66554F")
        }
    
    private let priceLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 22, weight: .bold)
            $0.textColor = UIColor(hex: "66554F")
        }
    
    private let separator = UIView()
    
    private let productDetailTitleLabel = UILabel()
        .then {
            $0.text = "Product details"
            $0.font = .montFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(hex: "66554F")
        }
    
    private let productDetailLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 14, weight: .medium)
            $0.textColor = UIColor(hex: "929292")
            $0.numberOfLines = 0
        }
    
    private let sendButton = PaddingButton(UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 10))
        .then {
            $0.backgroundColor = UIColor(hex: "FF6464")
            $0.layer.cornerRadius = 8
            $0.setTitle("Send a surprise", for: .normal)
            $0.setImage(UIImage(named: "gift"), for: .normal)
            $0.titleLabel?.font = .montFont(ofSize: 14, weight: .semibold)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bind()
    }
    
    private func selectTargetFromContact() {
        let contactPicker = CNContactPickerViewController()
        self.present(contactPicker, animated: true)
    }
    
    private func bind() {
        assert(viewModel != nil)
        
        let input = GiftDetailViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.gift.drive(onNext: {
            [weak self] gift in
            guard let self = self else { return }
            self.productNameLabel.text = gift.productName
            self.priceLabel.text = "$ \(gift.price)"
            self.productDetailLabel.text = gift.productDetail
        }).disposed(by: disposeBag)
        
        scrollView.rx.didScroll.asDriver().drive(onNext: {
            [weak self] in
            guard let self = self else { return }
            
            let targetHeight = self.productImageView.bounds.height - (self.navigationController?.navigationBar.bounds.height)! - (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
            
            var offset = self.scrollView.contentOffset.y / targetHeight
            
            if offset > 1 { offset = 1 }
            
            self.navigationController?.navigationBar.backgroundColor = UIColor(hue: 1, saturation: 0, brightness: 1, alpha: offset)
            self.statusBar.backgroundColor = UIColor(hue: 1, saturation: 0, brightness: 1, alpha: offset)
            
        }).disposed(by: disposeBag)
        
        sendButton.rx.tap
            .asDriver()
            .drive(onNext: {
                [weak self] in
                guard let self = self else { return }
                self.selectTargetFromContact()
            }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
//        if #available(iOS 14.0, *) {
//            navigationController?.navigationItem.backButtonDisplayMode = .minimal
//        } else {
//            // Fallback on earlier versions
//            ㅜ
//        }
        
        statusBar = UIView(frame: UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame ?? .zero)
        statusBar.isOpaque = false
        statusBar.backgroundColor = .clear
        
        self.view.addSubview(scrollView)
        self.view.addSubview(sendButton)
        self.view.addSubview(statusBar)
        
        scrollView.addSubview(productImageView)
        scrollView.addSubview(productInfoView)
        
        productInfoView.addSubview(productNameLabel)
        productInfoView.addSubview(priceLabel)
        productInfoView.addSubview(separator)
        productInfoView.addSubview(productDetailTitleLabel)
        productInfoView.addSubview(productDetailLabel)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(productImageView.snp.width)
        }
        
        productInfoView.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).inset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        productDetailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        productDetailLabel.snp.makeConstraints {
            $0.top.equalTo(productDetailTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(37)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hex: "AEAEB2").cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [8, 6]
        shapeLayer.lineJoin = .round
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 20, y: 0), CGPoint(x: self.view.frame.width - 20, y: 3)])
        shapeLayer.path = path
        separator.layer.addSublayer(shapeLayer)
    }
}
