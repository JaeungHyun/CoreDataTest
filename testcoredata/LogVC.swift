//
//  LogVC.swift
//  testcoredata
//
//  Created by JaeUng Hyun on 10/05/2019.
//  Copyright © 2019 JaeUng Hyun. All rights reserved.
//

import UIKit
import CoreData

class LogVC: UITableViewController {
    var board: BoardMO! // 게시글 정보를 전달받을 변수
    
    lazy var list: [LogMO]! = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LogMO> = LogMO.fetchRequest()
        let predict = NSPredicate(format: "board == %@", self.board)
        fetchRequest.predicate = predict
        
        let sort = NSSortDescriptor(key: "regDate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            NSLog("An error has occurred while list : %@, %@", error, error.userInfo)
            return []
        }
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = self.board?.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
        cell.textLabel?.text = "\(row.regDate!)에 \(row.type.toLogType())되었습니다"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
}

public enum LogType: Int16 {
    case create = 0
    case edit = 1
    case delete = 2
}

extension Int16 {
    func toLogType() -> String {
        switch self {
        case 0: return "생성"
        case 1: return "수정"
        case 2: return "삭제"
        default: return ""
        }
    }
}
