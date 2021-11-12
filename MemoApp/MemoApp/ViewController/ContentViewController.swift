//
//  ContentViewController.swift
//  MemoApp
//
//  Created by 백유정 on 2021/11/12.
//

import UIKit
import RealmSwift

class ContentViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    static let identifier = "ContentViewController"
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "메모", style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonClicked() {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy. MM. dd."
        
        let titleText = contentTextView.text.split(separator: "\n", maxSplits: 1).map(String.init)[0]
        
        let contentText = contentTextView.text.split(separator: "\n", maxSplits: 1).map(String.init)[1]
        
        let task = UserMemo(title: titleText,
                             content: contentText,
                             writeDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

}
