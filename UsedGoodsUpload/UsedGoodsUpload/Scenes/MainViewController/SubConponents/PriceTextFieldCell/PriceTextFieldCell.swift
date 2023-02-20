//
//  PriceTextFieldCell.swift
//  UsedGoodsUpload
//
//  Created by 전성규 on 2023/02/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PriceTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let priceInputField = UITextField()
    let freeShareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellViewModel) {
        viewModel.showFreeShareButton
            .map { !$0 }
            .emit(to: freeShareButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.resetPrice
            .map {_ in ""}
            .emit(to: priceInputField.rx.text)
            .disposed(by: disposeBag)
        
        priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: disposeBag)
        
        freeShareButton.rx.tap
            .bind(to: viewModel.freeShareButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        freeShareButton.setTitle("무료나눔", for: .normal)
        freeShareButton.setTitleColor(.orange, for: .normal)
        freeShareButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        freeShareButton.titleLabel?.font = .systemFont(ofSize: 18.0
        )
        freeShareButton.tintColor = .orange
        freeShareButton.backgroundColor = .white
        freeShareButton.layer.borderColor = UIColor.orange.cgColor
        freeShareButton.layer.borderWidth = 1.0
        freeShareButton.layer.cornerRadius = 10.0
        freeShareButton.clipsToBounds = true
        freeShareButton.isHidden = true
        freeShareButton.semanticContentAttribute = .forceLeftToRight
        
        priceInputField.keyboardType = .numberPad
        priceInputField.font = .systemFont(ofSize: 17.0)
    }
    
    private func layout() {
        [priceInputField, freeShareButton].forEach { contentView.addSubview($0) }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
        
        freeShareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15.0)
            $0.width.equalTo(100.0)
        }
            
    }
}
