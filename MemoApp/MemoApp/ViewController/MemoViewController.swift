//
//  ViewController.swift
//  MemoApp
//
//  Created by 백유정 on 2021/11/08.
//

import UIKit
import RealmSwift

enum MemoSection: Int, CaseIterable {
    case pinned
    case basic
    
    var description: String {
        switch self {
        case .pinned:
            return "고정된 메모"
        case .basic:
            return "메모"
        }
    }
}

class MemoViewController: UIViewController {
    
    var pinnedList: [String] = []
    var basicList: [String] = []
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserMemo>!

    @IBOutlet weak var memoSearchBar: UISearchBar!
    @IBOutlet weak var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTableView.delegate = self
        memoTableView.dataSource = self
        
        customAppearance()
        
        tasks = localRealm.objects(UserMemo.self)
        print("테스크", tasks)
        print(localRealm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memoTableView.reloadData()
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
    
    func addMemo(selectedLabel: UILabel) {
        let row = tasks[selectedLabel.tag]
        
        if row.pinned == true {
            self.pinnedList.removeAll()
            self.pinnedList.append(row.content!)
        } else {
            self.basicList.removeAll()
            self.basicList.append(row.content!)
        }
    }
    
    @IBAction func writeButtonClicked(_ sender: UIBarButtonItem) {
        print("작성 버튼 클릭")
        
        // 1. storyboard
        let sb = UIStoryboard(name: "Content", bundle: nil)
        
        // 2. viewcontroller
        let vc = sb.instantiateViewController(withIdentifier: ContentViewController.identifier) as! ContentViewController
        
        // 3. push
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MemoSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MemoSection.allCases[section].description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if section == 0 {
            return pinnedList.count
        } else {
            return basicList.count
        }
        */
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = memoTableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        addMemo(selectedLabel: cell.titleLabel)
        
        let row = tasks[indexPath.row]
        
        cell.titleLabel.tag = indexPath.row
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        try! localRealm.write {
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let row = tasks[indexPath.row]
        
        let pinned = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("pinned 클릭")
            
            try! self.localRealm.write {
                if row.pinned == false {
                    row.pinned = true
                } else {
                    row.pinned = false
                }
                
                if row.pinned == true {
                    self.pinnedList.removeAll()
                    self.pinnedList.append(row.title)
                } else {
                    self.basicList.removeAll()
                    self.basicList.append(row.title)
                }
                
                tableView.reloadData()
            }
            
            success(true)
        }
        
        pinned.backgroundColor = .orange
        pinned.image = UIImage(systemName: "pin.fill")
        
        return UISwipeActionsConfiguration(actions: [pinned])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        // 1. storyboard
        let sb = UIStoryboard(name: "Content", bundle: nil)
        
        // 2. viewcontroller
        let vc = sb.instantiateViewController(withIdentifier: ContentViewController.identifier) as! ContentViewController
        
        // 3. push
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
