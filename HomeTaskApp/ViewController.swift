//
//  ViewController.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/04/19.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    // インスタンス変数
    var DBRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        //インスタンスを作成
        DBRef = Database.database().reference()
    }

    @IBAction func add(_ sender: AnyObject) {
        let data = ["name": textField.text!]
        DBRef.child("user/01").setValue(data)
    }
}

