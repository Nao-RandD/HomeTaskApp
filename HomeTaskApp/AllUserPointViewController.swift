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

    override func viewDidLoad() {
        //インスタンスを作成
        DBRef = Database.database().reference()


    }

    private func calPoint(snapshot: DataSnapshot) {
//        for child in snapshot.children {
//            let subObj = child as? DataSnapshot
//            if let obj = subObj?.value as? [String : AnyObject],
//                let name = obj["name"] as? String,
//                let point = obj["point"] as? Int,
//                let date = obj["date"] as? String {
//
//                let currentText = self.textView.text
//                self.textView.text = (currentText ?? "") + "\n\(name) : \(point)point || \(date)"
//                self.sumUserPoint(point)
//            } else {
//                print("データ情報に誤りあり？")
//            }
//        }
    }

    private func sumUserPoint(_ point: Int) {
//        userPoint += point
//        dataLabel.text = "あなたのポイント合計は\(userPoint)です"
    }
}
