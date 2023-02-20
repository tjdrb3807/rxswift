//
//  MainModel.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/11.
//

import RxSwift

struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<DKBlog, SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result  else { return nil }
        
        return value
    }
    
    func getBlogError(_ result: Result<DKBlog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else { return nil }
        
        return error.localizedDescription
    }
    
    func getBlogListCellData(_ value: DKBlog) -> [BlogListCellData] {
        value.documents
            .map { document in
                let thumbnailURL = URL(string: document.thumbnail ?? "")
                
                return BlogListCellData(thumbnailURL: thumbnailURL,
                                        name: document.name,
                                        title: document.title,
                                        datetime: document.datetime)
            }
    }
    
    func sory(by type: MainViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? "" }
        case .datetime:
            return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
        default:
            return data
        }
    }
}
