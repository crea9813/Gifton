//
//  GiftConfirmViewController.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/13.
//

import UIKit
import RxSwift
import SPConfetti

final class GiftConfirmViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 30, weight: .semibold)
            $0.textColor = UIColor(hex: "66554F")
            $0.text = "Order Confirm"
        }
    
    private let subTitleLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 18, weight: .medium)
            $0.textColor = UIColor(hex: "929292")
            $0.text = "The gift will be delivered soon."
        }
    
    private let sendButton = PaddingButton(UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14))
        .then {
            $0.backgroundColor = UIColor(hex: "FF6464")
            $0.layer.cornerRadius = 8
            $0.setTitle("Back to Main", for: .normal)
            $0.titleLabel?.font = .montFont(ofSize: 14, weight: .semibold)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle, .arc])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bind()
    }
    
    private func bind() {
        self.sendButton.rx
            .tap
            .asDriver()
            .drive(onNext: {
                [weak self] in
                guard let self = self else { return }
                SPConfetti.stopAnimating()
                self.navigationController?.popToRootViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(subTitleLabel)
        self.view.addSubview(sendButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(300)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
    }
}
