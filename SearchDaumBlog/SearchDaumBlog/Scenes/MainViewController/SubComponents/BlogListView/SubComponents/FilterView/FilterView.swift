//
//  FilterView.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/09.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class FilterView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    // sortButton이 Tapped되면 Alert Sheet가 올라온다
    // FilterView는 BlogListView의 Component이며, BlogListView는 MainViewController의 Component이다.
    // 따라서 sortButton이 Tapped 됐을때 MainViewController가 Alert Sheet를 띄울것이다.
    // 결과적으로 FilterView는 sortButton이 Tap 됐을 때 Event를 밖(MainViewController)로 방출하는 역할을 갖는다.
    let sortButton = UIButton()
    let bottmBorder = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: FilterViewModel) {
        sortButton.rx.tap
            .bind(to: viewModel.sortButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottmBorder.backgroundColor = .separator
    }
    
    private func layout() {
        [sortButton, bottmBorder].forEach { addSubview($0) }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.0)
            $0.width.height.equalTo(28.0)
        }
        
        bottmBorder.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}

