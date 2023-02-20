//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/11.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let blogListViewModel = BlogListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    // AlertAction이 Tap 됐을때 방출되는 Event를 확인하기위한 Subject
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    var shoultPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel()) {
        // 03
            let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog)
            .share()
            
            // 04
            let blogValue = blogResult
            .compactMap(model.getBlogValue)
            
            // 05
            let blogError = blogResult
            .compactMap(model.getBlogError)
            
            // 06
            // 네트워크를 통해 가져온 값을 cellData로 변환 작업
            let cellData = blogValue
            .map(model.getBlogListCellData)
            
            // 07
            // FilterView를 선택했을 때 나오는 Alert Sheet를 선택했을 때 타입으로 sort
            let sortedType = alertActionTapped
                .filter {
                    switch $0 {
                    case .title, .datetime:
                        return true
                    default:
                        return false
                    }
                }.startWith(.title)
            
            // 08
            // cellData를 MainViewController -> ListView
            Observable
            .combineLatest(sortedType, cellData, resultSelector: model.sory)
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)
                
            
            // 01
            // sortButton 이 눌렸을때 구현한 Alert이 나오로록
            let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
                .map { _ -> MainViewController.Alert in
                    MainViewController.Alert(title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
                }
            
            // 09
            let alertForErrorMessage = blogError
                .map { message -> MainViewController.Alert in
                    return (title: "앗!",
                            message: "예상치 못한 오류가 발생했습니다. 잠시후 다시 시도해주세요. \(message)",
                            actions: [.confirm],
                            style: .alert)
                }
            
            self.shoultPresentAlert = Observable
                .merge(alertForErrorMessage, alertSheetForSorting)
                .asSignal(onErrorSignalWith: .empty())
        }
}
