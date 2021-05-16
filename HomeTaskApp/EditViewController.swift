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

    // インスタンス変数
    var DBRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()

//        DBRef.observe(.childAdded, with: { snapshot in
//            if let obj = snapshot.value as? [String : AnyObject],
//               let name = obj["name"] as? String,let message = obj["message"] {
//                let currentText = self.textView.text
//                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
//            }
//        })
    }

    @IBAction func getDataFirebase(_ sender: Any) {
        self.DBRef.child("user/01").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
                self.dataLabel.text = "\(error)"
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                self.dataLabel.text = "\(snapshot.value ?? "データなし")"
            }
            else {
                print("No data available")
                self.dataLabel.text = "データなし"
            }
        }
    }

}
