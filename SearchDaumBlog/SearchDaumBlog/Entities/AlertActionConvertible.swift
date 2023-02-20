//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/09.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
