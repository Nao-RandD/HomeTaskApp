//
//  TaskModel.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/07/07.
//

import Foundation

class TaskPointModel {
    static let notificationName = "TaskPointModelChanged"

    let notificationCenter = NotificationCenter()

    internal var count: Int = 0 {
        didSet {
            // Modelを監視しているコントローラに変更を通知
            notificationCenter.post(
                name: .init(rawValue: TaskPointModel.notificationName),
                object: count
            )
        }
    }

    // 数値がいくらなのか保持する
    func countUp() {
        count += 1
    }

    func countDown() {
        count -= 1
    }
}
