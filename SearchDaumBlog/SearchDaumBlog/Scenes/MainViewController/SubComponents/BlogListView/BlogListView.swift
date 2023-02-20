//
//  BlogListView.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/09.
//

import UIKit
import RxSwift
import RxCocoa

class BlogListView: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50.0)))
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // cellData: PublishSubject(Observable)에서 받은 Event를 처리하는 기능 구현
    func bind(_ viewModel: BlogListViewModel) {
        headerView.bind(viewModel.filterViewModel)
        /*
         - cellData는 UI에 관한 것이므로 Observable로 변환하기 위해 asDriver를 사용한다.
         - rx.times는 tableView와 row, cellData의 Element를 넘겨준다.
         */
        viewModel.cellData
//            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tableView, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as! BlogListCell
                cell.setData(data)
                
                return cell
            }.disposed(by: disposeBag)
            
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100.0
        self.tableHeaderView = headerView
    }
}
