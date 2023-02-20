//
//  DetailWriteFormCell.swift
//  UsedGoodsUpload
//
//  Created by 전성규 on 2023/02/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DetailWriteFormCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let contentInputView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailWriteFormCellViewModel) {
        contentInputView.rx.text
            .bind(to: viewModel.contentValue)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        contentInputView.font = .systemFont(ofSize: 17.0)
    }
    
    private func layout() {
        contentView.addSubview(contentInputView)
        
        contentInputView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(300.0)
        }
    }
}
