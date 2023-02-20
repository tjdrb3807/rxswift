//
//  BlogListCellData.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/09.
//

import Foundation

// Network Value 이므로 없는 경우를 대비해서 Optional 처리해준다.
struct BlogListCellData {
    let thumbnailURL: URL?
    let name: String?
    let title: String?
    let datetime: Date?
}
