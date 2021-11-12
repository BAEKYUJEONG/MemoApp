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
        contentLabel.text = row.content
        
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
