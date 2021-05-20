//
//  EditViewController.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/05/16.
//

import Firebase
import UIKit


class EditViewController: UIViewController {
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    // インスタンス変数
    private var DBRef: DatabaseReference!
    private var userPoint: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()

        DBRef.observe(.childAdded, with: { snapshot in
//            dump(snapshot) // 一覧表示したいとき
            for child in snapshot.children {
                let subObj = child as? DataSnapshot
                if let obj = subObj?.value as? [String : AnyObject],
                    let name = obj["name"] as? String,
                    let point = obj["point"] as? Int,
                    let date = obj["date"] as? String {

                    let currentText = self.textView.text
                    self.textView.text = (currentText ?? "") + "\n\(name) : \(point)point || \(date)"
                    self.sumUserPoint(point)
                } else {
                    print("データ情報に誤りあり？")
                }
            }

//            if let obj = snapshot.value as? [String : AnyObject],
//                let user = obj["user"] as? String {
//                print("選択は\(user)です")
//                let currentText = self.textView.text
//                self.textView.text = (currentText ?? "") + "\n\(name) : \(point)"
//                self.sumUserPoint(point)
//            } else {
//                print("データ情報に誤りあり？")
//            }
        })
    }

    private func sumUserPoint(_ point: Int) {
        userPoint += point
        dataLabel.text = "あなたのポイント合計は\(userPoint)です"
    }

    @IBAction func getDataFirebase(_ sender: Any) {
        self.DBRef.child("user").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
                self.dataLabel.text = "\(error)"
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                let subObj = snapshot.children as? DataSnapshot
                let obj = subObj?.value as? [String : AnyObject]
                dump(obj)
                let task = obj?["name"] as? String
                print("Data is \(task)")
                // メインスレッドでUIを更新する
                DispatchQueue.main.async {
                    self.dataLabel.text = "\(task)"
                }
            }
            else {
                print("No data available")
                DispatchQueue.main.async {
                    self.dataLabel.text = "データなし"
                }
            }
        }
    }

}
