//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/11.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    /*
     PublishRealy
        - PublishSubject를 Wrapping 하고있다.
        - Error Event를 받지 않는다.
        - UI Component, UI Event에 특화됐다
        - Button Event는 별도의 Element(Value)가 전달되지 않고 Event만 전달되므로 Void로 명시한다.
     */
    let searchButtonTapped = PublishRelay<Void>()
    
    // SearchBar 외부로 내보낼 이벤트(Element: text)
    var shouldLoadResult = Observable<String>.of("")
    
    init() {
        /*
         - searchButton이 Tapped 됐을때 SearchBar에 입력돼있는 text를 외부(MainViewController) 즉, SearchBar를 Subscrib하고있는 어떠한 View에도 연결해주어야햔다.
         - 따라서 shouldLoadResult가 어떠한 text를 받을지 연결해주어야한다.
         - SearchBar가 searchButton을 눌렀을 때 Trigger로 해서 text를 방출해야한다.
            - withLaTestFrom 이라는 Trigger Operator를 사용해서 구현한다.
         */
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty  }
            .distinctUntilChanged()
            
    }
}
