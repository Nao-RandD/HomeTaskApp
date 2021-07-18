//
//  AllUserPointViewController.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/05/21.
//

import Firebase
import UIKit

class AllUserPointViewController: UIViewController {
    // インスタンス変数
    private var DBRef: DatabaseReference!
    private let allUsers = User.allCases.map { $0.name }

    // UI上の値
    @IBOutlet weak var firstUserName: UILabel!
    @IBOutlet var firstUserLabel: [UILabel]!
    @IBOutlet weak var firstUserSum: UILabel!

    @IBOutlet weak var secondUserName: UILabel!
    @IBOutlet var secondUserLabel: [UILabel]!
    @IBOutlet weak var secondUserSum: UILabel!

    @IBOutlet weak var thirdUserName: UILabel!
    @IBOutlet var thirdUserLabel: [UILabel]!
    @IBOutlet weak var thirdUserSum: UILabel!

    // ポイント管理の変数
    private var taskPoint1: Int = 0
    private var taskPoint2: Int = 0
    private var taskPoint3: Int = 0
    private var taskPoint4: Int = 0
    private var totalPoint: Int = 0

    override func viewDidLoad() {
        //インスタンスを作成
        DBRef = Database.database().reference()

//        DBRef.child("default").observe(.childAdded, with: { snapshot in
//            self.calPoint(snapshot: snapshot)
//        })

        // ユーザー全てのObserverを設定
        for user in allUsers {
            print(user)
            DBRef.child(user).observeSingleEvent(of: .value, with: { snapshot in
                dump(snapshot)
                self.calPoint(snapshot: snapshot, user: user)
            })
        }
    }

    // FireBaseから取得したデータを計算するメソッド
    private func calPoint(snapshot: DataSnapshot, user: String) {
        for child in snapshot.children {
            let subObj = child as? DataSnapshot
            if let obj = subObj?.value as? [String : AnyObject],
                let name = obj["name"] as? String,
                let point = obj["point"] as? Int,
                let date = obj["date"] as? String {

//                self.textView.text = (currentText ?? "") + "\n\(name) : \(point)point || \(date)"
                self.sumUserPoint(name: name, point: point, user: user)
            } else {
                print("データ情報に誤りあり？")
            }
        }
    }

    // 取得したデータ
    private func sumUserPoint(name: String, point: Int, user: String) {
        switch  user {
        case "Shin":
            firstUserName.text = user
            hoge(taskLabels: firstUserLabel, totalValue: firstUserSum, point: point, taskName: name)
        case "Nao":
            secondUserName.text = user
            hoge(taskLabels: secondUserLabel, totalValue: secondUserSum, point: point, taskName: name)
        case "Ryoya":
            thirdUserName.text = user
            hoge(taskLabels: thirdUserLabel, totalValue: thirdUserSum, point: point, taskName: name)
        default:
            print("知らないユーザーなり")
        }
    }

    private func hoge(taskLabels: [UILabel], totalValue: UILabel, point: Int, taskName: String) {
        switch taskName {
        case "洗濯":
            taskPoint1 += point
            taskLabels[0].text = String(taskPoint1)
        case "掃除":
            taskPoint2 += point
            taskLabels[1].text = String(taskPoint2)
        case "皿洗い":
            taskPoint3 += point
            taskLabels[2].text = String(taskPoint3)
        default:
            taskPoint4 += point
            taskLabels[3].text = String(taskPoint4)
        }
        totalPoint += point
        totalValue.text = String(totalPoint)
    }
}
