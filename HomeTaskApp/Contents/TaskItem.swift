//
//  TaskItem.swift
//  
//
//  Created by Naoyuki Kan on 2021/08/12.
//

import Foundation
import RealmSwift

class TaskItem: Object {
    @objc dynamic var itemid = 0
    @objc dynamic var username = ""
    @objc dynamic var taskname = ""
    @objc dynamic var category = ""
    @objc dynamic var date = ""
    override static func primaryKey() -> String? {
        return "itemid"
    }
}
