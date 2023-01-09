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
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(hex: "66554F")
        $0.text = "Most Popular"
    }
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        bind()
    }
    
    
    private func bind() {
        assert(viewModel != nil)
        
        let input = GiftsViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output
            .categories
            .drive(categoriesCollectionView.rx.items(cellIdentifier: GiftCategoryCollectionViewCell.reuseIdentifier, cellType: GiftCategoryCollectionViewCell.self)) {
                index, viewModel, cell in
                cell.bind(with: viewModel)
            }.disposed(by: disposeBag)
    }
    
    private func setupUI() {
        
        self.view.addSubview(searchBar)
        self.view.addSubview(categoriesCollectionView)
        self.view.addSubview(tableTitleLabel)
        self.view.addSubview(tableView)
        
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        self.categoriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(30)
            $0.height.equalTo(120)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.tableTitleLabel.snp.makeConstraints {
            $0.top.equalTo(categoriesCollectionView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(30)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(tableTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
