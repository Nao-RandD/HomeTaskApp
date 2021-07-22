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
    private var taskList = ["洗濯入れ", "洗濯出し", "食器入れ", "食器出し" ]

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

    @IBOutlet var firstTaskCollection: [UILabel]!
    @IBOutlet var secondTaskCollection: [UILabel]!
    @IBOutlet var thirdTaskCollection: [UILabel]!



    // ポイント管理の変数
    private var taskPointList1 = [0, 0, 0, 0]
    private var taskPointList2 = [0, 0, 0, 0]
    private var taskPointList3 = [0, 0, 0, 0]
//    private var taskPoint4: Int = 0

    private var totalPoint1: Int = 0
    private var totalPoint2: Int = 0
    private var totalPoint3: Int = 0

    override func viewDidLoad() {
        //インスタンスを作成
        DBRef = Database.database().reference()

//        DBRef.child("default").observe(.childAdded, with: { snapshot in
//            self.calPoint(snapshot: snapshot)
//        })
        setTaskLabel()

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
            hoge(user: user, taskLabels: firstUserLabel, totalValue: firstUserSum, point: point, taskName: name)
        case "Nao":
            secondUserName.text = user
            hoge(user: user,taskLabels: secondUserLabel, totalValue: secondUserSum, point: point, taskName: name)
        case "Ryoya":
            thirdUserName.text = user
            hoge(user: user, taskLabels: thirdUserLabel, totalValue: thirdUserSum, point: point, taskName: name)
        default:
            print("知らないユーザーなり")
        }
    }

    private func setTaskLabel() {
        firstUserName.text = allUsers[0]
        secondUserName.text = allUsers[1]
        thirdUserName.text = allUsers[2]

        var i = 0
        for task in taskList {
            firstTaskCollection[i].text = task
            secondTaskCollection[i].text = task
            thirdTaskCollection[i].text = task
            i += 1
        }
    }

    private func hoge(user: String,taskLabels: [UILabel], totalValue: UILabel, point: Int, taskName: String) {

        switch user {
        case "Shin":
            switch taskName {
            case taskList[0]:
                taskPointList1[0] += point
                taskLabels[0].text = String(taskPointList1[0])
            case taskList[1]:
                taskPointList1[1] += point
                taskLabels[1].text = String(taskPointList1[1])
            case taskList[2]:
                taskPointList1[2] += point
                taskLabels[2].text = String(taskPointList1[2])
            default:
                taskPointList1[3] += point
                taskLabels[3].text = String(taskPointList1[3])
            }
            totalPoint1 += point
            totalValue.text = String(totalPoint1)
        case "Nao":
            switch taskName {
            case taskList[0]:
                taskPointList2[0] += point
                taskLabels[0].text = String(taskPointList2[0])
            case taskList[1]:
                taskPointList2[1] += point
                taskLabels[1].text = String(taskPointList2[1])
            case taskList[2]:
                taskPointList2[2] += point
                taskLabels[2].text = String(taskPointList2[2])
            default:
                taskPointList2[3] += point
                taskLabels[3].text = String(taskPointList2[3])
            }
            totalPoint2 += point
            totalValue.text = String(totalPoint2)
        case "Ryoya":
            switch taskName {
            case taskList[0]:
                taskPointList3[0] += point
                taskLabels[0].text = String(taskPointList3[0])
            case taskList[1]:
                taskPointList3[1] += point
                taskLabels[1].text = String(taskPointList3[1])
            case taskList[2]:
                taskPointList3[2] += point
                taskLabels[2].text = String(taskPointList3[2])
            default:
                taskPointList3[3] += point
                taskLabels[3].text = String(taskPointList3[3])
            }
            totalPoint3 += point
            totalValue.text = String(totalPoint3)
        default:
            print("知らないユーザーなり")
        }

    }
}
