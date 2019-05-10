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
