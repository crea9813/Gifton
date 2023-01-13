//
//  GiftCardViewController.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/12.
//

import UIKit
import RxSwift

final class GiftCardViewController: UIViewController {
 
    static func create(with viewModel: GiftCardViewModel) -> GiftCardViewController {
        let view = GiftCardViewController()
        view.viewModel = viewModel
        return view
    }
    
    private var viewModel: GiftCardViewModel!
    
    private let disposeBag = DisposeBag()
    
    private let cardTitleLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 30, weight: .bold)
            $0.textColor = UIColor(hex: "66554F")
            $0.text = "Create Card"
        }
    
    private let cardCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: 240)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GiftCardCollectionViewCell.self, forCellWithReuseIdentifier: GiftCardCollectionViewCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let messageTitleLabel = UILabel()
        .then {
            $0.font = .montFont(ofSize: 12, weight: .medium)
            $0.textColor = UIColor(hex: "929292")
            $0.text = "Add a message (optional)"
        }
    
    private let messageTextField = UITextField()
        .then {
            $0.font = .montFont(ofSize: 16, weight: .medium)
            $0.textColor = UIColor(hex: "66554F")
        }
    
    private let textFieldLine = UIView()
        .then {
            $0.backgroundColor = UIColor(hex: "D2D2D2")
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
    
    private func bind() {
        assert(viewModel != nil)
        
        let didSendGift = self.sendButton.rx.tap.asDriver()
        
        let message = self.messageTextField.rx.text.orEmpty.asDriver()
        
        let input = GiftCardViewModel.Input(didSendGift: didSendGift,
                                            message: message)
        
        let output = viewModel.transform(input: input)
        
        output
            .cards
            .drive(cardCollectionView.rx.items(cellIdentifier: GiftCardCollectionViewCell.reuseIdentifier, cellType: GiftCardCollectionViewCell.self)) {
                index, viewModel, cell in
                cell.bind(with: viewModel)
            }.disposed(by: disposeBag)
        
        output.sendGift.drive().disposed(by: disposeBag)
        
        cardCollectionView.rx.willEndDragging.asDriver().drive(onNext: {
            [weak self] vecolity, offset in
            guard let self = self else { return }
            guard let layout = self.cardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            let scrolledOffsetX = offset.pointee.x + self.cardCollectionView.contentInset.left
            let cellWidth = layout.itemSize.width + layout.minimumInteritemSpacing
            let index = round(scrolledOffsetX / cellWidth)
            offset.pointee = CGPoint(x: index * cellWidth - self.cardCollectionView.contentInset.left, y: 0)
        }).disposed(by: disposeBag)
        
        let viewTapGesture = UITapGestureRecognizer()
        self.view.addGestureRecognizer(viewTapGesture)
        
        viewTapGesture.rx
            .event
            .asDriver()
            .drive(onNext: {
                [weak self] _ in
                guard let self = self else { return }
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(cardTitleLabel)
        self.view.addSubview(cardCollectionView)
        self.view.addSubview(messageTitleLabel)
        self.view.addSubview(messageTextField)
        self.view.addSubview(textFieldLine)
        self.view.addSubview(sendButton)
        
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        cardCollectionView.snp.makeConstraints {
            $0.top.equalTo(cardTitleLabel.snp.bottom)
            $0.height.equalTo(300)
            $0.leading.trailing.equalToSuperview()
        }
        
        messageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        messageTextField.snp.makeConstraints {
            $0.top.equalTo(messageTitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        textFieldLine.snp.makeConstraints {
            $0.top.equalTo(messageTextField.snp.bottom)
            $0.leading.trailing.equalTo(messageTextField)
            $0.height.equalTo(1)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(37)
        }
    }
}
