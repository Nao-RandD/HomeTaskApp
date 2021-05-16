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

    // インスタンス変数
    var DBRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        //インスタンスを作成
        DBRef = Database.database().reference()
    }

    @IBAction func add(_ sender: AnyObject) {
        let data = ["name": textField.text!]
        DBRef.childByAutoId().setValue(data)
    }
    @IBAction func tapButton1(_ sender: Any) {
        setLabel("掃除")
    }
    @IBAction func tapButton2(_ sender: Any) {
        setLabel("洗濯")
    }
    @IBAction func tapButton3(_ sender: Any) {
        setLabel("皿洗い")
    }
    @IBAction func tapButton4(_ sender: Any) {
        setLabel("その他")
    }

    private func setLabel(_ btText: String) {
        let text = "\(btText)のボタンが選択されています"
        taskLabel.text = text
    }
}

