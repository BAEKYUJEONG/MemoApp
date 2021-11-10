//
//  ViewController.swift
//  MemoApp
//
//  Created by 백유정 on 2021/11/08.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var memoSearchBar: UISearchBar!
    @IBOutlet weak var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTableView.delegate = self
        memoTableView.dataSource = self
        
        customAppearance()
    }

    func customAppearance() {
        navigationItem.title = "0개의 메모"
        memoTableView.backgroundColor = .systemGray
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.configureWithDefaultBackground()
        
        navBarAppearance.backgroundColor = UIColor.systemGray
        
        navBarAppearance.titleTextAttributes = [
                .foregroundColor : UIColor.purple,
                .font : UIFont.italicSystemFont(ofSize: 17)
            ]

            navBarAppearance.largeTitleTextAttributes = [
                .foregroundColor : UIColor.systemBlue,
            ]
    }
    
    func customSearchBar() {
        
    }
}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = memoTableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
