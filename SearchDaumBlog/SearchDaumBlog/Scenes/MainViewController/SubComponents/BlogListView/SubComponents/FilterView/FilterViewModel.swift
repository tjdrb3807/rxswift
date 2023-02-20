//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/11.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    // FilterView에서 방출한 Evnet를 Subscribe할 Observable
    let sortButtonTapped = PublishRelay<Void>()
}
