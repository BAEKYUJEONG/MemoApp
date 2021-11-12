//
//  MemoTableViewCell.swift
//  MemoApp
//
//  Created by 백유정 on 2021/11/08.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    static let identifier = "MemoTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configureCell(row: UserMemo) {
        titleLabel.text = row.title
        
        // 컨텐츠의 맨 앞쪽 띄어쓰기, 엔터 등은 TableView에 보여주지 않기 위한 알고리즘
        if var content = row.content {
            var flag: Bool = true
            
            while flag {
                if content[content.startIndex] == " " {
                    //substring을 이용한 방법
                    let startIndex = content.index(content.startIndex, offsetBy: 1)
                    content = content.substring(from: startIndex)
                } else if content[content.startIndex] == "\n" {
                    //split을 이용한 방법
                    content = content.split(separator: "\n", maxSplits: 1).map(String.init)[1]
                } else {
                    flag = false
                }
            }
            
            contentLabel.text = content
        }
        
        let format = DateFormatter()
        format.dateFormat = "yyyy. MM. dd."
        dateLabel.text = format.string(from: row.writeDate)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
