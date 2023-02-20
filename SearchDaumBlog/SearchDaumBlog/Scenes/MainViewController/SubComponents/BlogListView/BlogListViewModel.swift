//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/11.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    // BlogListView가 FilterView를 header로 갖고 있으므로 추가해준다.
    let filterViewModel = FilterViewModel()
    
    // MainViewController 에서 네트워크 작업을 통해 전달된 값을 BlogListView에 받아와서 BlogLsitCell에 뿌려 BlogListView에 표현된다.
    // 따라서 MainViewController에서 방출된 Event를 Subscrib할 Subject를 정의한다.
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
    
    
}
