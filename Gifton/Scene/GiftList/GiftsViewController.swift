//
//  GiftsViewController.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/03.
//

import Then
import UIKit
import SnapKit
import RxSwift

final class GiftsViewController: UIViewController {
    
    static func create(with viewModel: GiftsViewModel) -> GiftsViewController {
        let view = GiftsViewController()
        view.viewModel = viewModel
        return view
    }
    
    private var viewModel: GiftsViewModel!
    
    private let disposeBag = DisposeBag()
    
    private let searchBar = SearchField()
    
    private let filterButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "drawer"), for: .normal)
            $0.backgroundColor = UIColor(hex: "E9E9EC")
            $0.layer.cornerRadius = 15
        }
    
    private let scrollView = UIScrollView()
        .then {
            $0.showsVerticalScrollIndicator = false
        }
    
    private let categoriesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 70, height: 120)
        flowLayout.minimumInteritemSpacing = 40
        flowLayout.minimumLineSpacing = 40
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GiftCategoryCollectionViewCell.self, forCellWithReuseIdentifier: GiftCategoryCollectionViewCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        return collectionView
    }()
    
    private let tableTitleLabel = UILabel().then {
        $0.font = .montFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(hex: "66554F")
        $0.text = "Most Popular"
    }
    
    private let giftCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 164, height: 250)
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = false
        collectionView.register(GiftCollectionViewCell.self, forCellWithReuseIdentifier: GiftCollectionViewCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
//        configureGiftCollectionView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.title = "Gifton"
    }
    
    private func configureGiftCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: (giftCollectionView.frame.size.width - 62) / 2, height: 250)
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        giftCollectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    private func bind() {
        assert(viewModel != nil)
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let didSelectCell = self.giftCollectionView.rx.itemSelected.asDriver()
        
        let input = GiftsViewModel.Input(loadGifts: viewWillAppear,
                                         didSelectGift: didSelectCell)
        
        let output = viewModel.transform(input: input)
        
        output
            .categories
            .drive(categoriesCollectionView.rx.items(cellIdentifier: GiftCategoryCollectionViewCell.reuseIdentifier, cellType: GiftCategoryCollectionViewCell.self)) {
                index, viewModel, cell in
                cell.bind(with: viewModel)
            }.disposed(by: disposeBag)
        
        output
            .gifts
            .drive(giftCollectionView.rx.items(cellIdentifier: GiftCollectionViewCell.reuseIdentifier, cellType: GiftCollectionViewCell.self)) {
                index, viewModel, cell in
                cell.bind(with: viewModel)
            }.disposed(by: disposeBag)
        
        output
            .gifts
            .map { $0.isEmpty }
            .drive(onNext: {
                [weak self] isEmpty in
                guard let self = self else { return }
                if isEmpty {
                    
                } else {
                    let height = Float(262) * ceil(Float(self.giftCollectionView.numberOfItems(inSection: 0) / 2))
                    print(self.giftCollectionView.numberOfItems(inSection: 0))
                    self.giftCollectionView.snp.updateConstraints {
                        $0.height.equalTo(height)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        output.selectGift.drive().disposed(by: disposeBag)
    }
    
    private func setupUI() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        self.view.addSubview(searchBar)
        self.view.addSubview(filterButton)
        self.view.addSubview(scrollView)
        scrollView.addSubview(categoriesCollectionView)
        scrollView.addSubview(tableTitleLabel)
        scrollView.addSubview(giftCollectionView)
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(25)
        }
        
        self.filterButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.searchBar)
            $0.width.equalTo(self.filterButton.snp.height)
            $0.leading.equalTo(self.searchBar.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.categoriesCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(120)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.tableTitleLabel.snp.makeConstraints {
            $0.top.equalTo(categoriesCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(25)
        }
        
        self.giftCollectionView.snp.makeConstraints {
            $0.top.equalTo(tableTitleLabel.snp.bottom).offset(10)
            $0.width.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
}
