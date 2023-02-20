//
//  BlogListCell.swift
//  SearchDaumBlog
//
//  Created by 전성규 on 2023/02/09.
//

import UIKit
import SnapKit
import Kingfisher

class BlogListCell: UITableViewCell {
    let thumbnailImageView = UIImageView()
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let datetimeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnailImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
        
        titleLabel.font = .systemFont(ofSize: 14.0)
        titleLabel.numberOfLines = 2
        
        datetimeLabel.font = .systemFont(ofSize: 12.0, weight: .light)
        
        [thumbnailImageView, nameLabel, titleLabel, datetimeLabel].forEach { addSubview($0) }
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(80.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8.0)
            $0.trailing.lessThanOrEqualTo(thumbnailImageView.snp.leading).offset(-8.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8.0)
        }
        
        datetimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
    }
    
    // 외부(BlogListView)에서 setData 메소드를 통해 BlogListCellData를 받아 UI를 어떻게 표현할지 정의한 기능
    func setData(_ data: BlogListCellData) {
        thumbnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        nameLabel.text = data.name
        titleLabel.text = data.title
        
        var datetime: String {
            let dateFormetter = DateFormatter()
            dateFormetter.dateFormat = "yyyy년 MM월 dd일 (EEEEE)"
            
            let contentDate = data.datetime ?? Date()
            
            return dateFormetter.string(from: contentDate)
        }
        
        datetimeLabel.text = datetime
    }
}
