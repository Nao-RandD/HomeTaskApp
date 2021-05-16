//
//  ViewController.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/04/19.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var taskLabel: UILabel!

    private var taskSelect = ""
    private var taskPoint = 0

    // インスタンス変数
    var DBRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        //インスタンスを作成
        DBRef = Database.database().reference()
    }

    @IBAction func add(_ sender: AnyObject) {
        let data = ["name": taskSelect, "point":
                        taskPoint] as [String : Any]
        DBRef.child("user").childByAutoId().setValue(data)
        print("タスク\(taskSelect)が選択されており、ポイントは\(taskPoint)です")
    }
    @IBAction func tapButton1(_ sender: Any) {
        setLabel("掃除", 5)
    }
    @IBAction func tapButton2(_ sender: Any) {
        setLabel("洗濯", 10)
    }
    @IBAction func tapButton3(_ sender: Any) {
        setLabel("皿洗い", 3)
    }
    @IBAction func tapButton4(_ sender: Any) {
        setLabel("その他", 1)
    }

    private func setLabel(_ btText: String, _ point: Int) {
        let text = "\(btText)のボタンが選択されています"
        taskLabel.text = text
        taskSelect = btText
        taskPoint = point
    }
}

