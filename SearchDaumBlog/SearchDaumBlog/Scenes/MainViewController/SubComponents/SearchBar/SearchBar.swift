//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/09.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        /*
         - searchButtonTapped 에 어떠한 Event를 방출해야할까???
         - 어떤 순간이 Search Button이 Tapped 된 순간이라 할 수 있을까???
            1. SearchBar에 search button이 tapped 된 순간
            2. searchButton이 tapped 된 순간
         - 위의 두가지 경우가 발생할 때 동일하게 검색을 실행한다.
         - 따라서 두 Observable의 순서와 상관없이 어떠한 Observable이든 Event를 방출하면 Tap Event라 볼 수 있다.
            - Combine Operator .merge를 사용해서 두 Observable을 가질 수 있다.
         */
        
        /*
         - searchButtonClicked와 tap의 타입은 ControlEvent<Void> 이다.
         - 우리는 merge를 통해 Observable로 만들어줄 것이므로 .asObservable()을 통해 타입을 변환시켜준다.
         */
        Observable
            .merge(self.rx.searchButtonClicked.asObservable(),
                   self.searchButton.rx.tap.asObservable()
            ).bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        /*
         - 그렇다면 merge로 잘 묶여진 Event가 방출된 때 어떠한 상황이 벌어지면 될까???
            - SearchBar 기준으로 EndEditting Event가 발생하면 키보드가 내려가거나 타이핑이 끝난것을 인지하게 된다.
         - 아래 코드의 결과로 serchButtonTapped에서 Evnet가 방출됐을 때 endEditing이 발현되서 키보드가 내려가게된다.
         */
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing) // 어디다 연결하냐??
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12.0)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12.0)
            $0.centerY.equalToSuperview()
        }
    }
} 

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) {base, _ in // base: SearchBar
            base.endEditing(true)
        }
    }
}
