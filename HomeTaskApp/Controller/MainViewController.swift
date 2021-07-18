//
//  MainViewController.swift
//  HomeTaskApp
//
//  Created by Naoyuki Kan on 2021/04/19.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var taskLabel: UILabel!

    private var userPickerView: UIPickerView!
    private var editingField: UITextField?

    private var taskSelect = ""
    private var taskPoint = 0
    private let dateFomatter = DateFormatter()
    private var userName = ""
    private let allUsers = User.allCases.map { $0.name }

    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    // インスタンス変数
    var DBRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.delegate = self
        dateFomatter.dateFormat = "yyyy/MM/dd"
        //インスタンスを作成
        DBRef = Database.database().reference()
        // デフォルト値
        userDefaults.register(defaults: ["User": "default"])

        // categoryPickerViewを設定
        userPickerView = UIPickerView()
        userPickerView.delegate = self
        userPickerView.dataSource = self
        userTextField.inputView = userPickerView
    }

    override func viewWillAppear(_ animated: Bool) {
//        userTextField.text = allUsers[0]
        userTextField.text = userDefaults.object(forKey: "User") as? String
        userName = userDefaults.object(forKey: "User") as? String ?? "default"
    }

    @IBAction func add(_ sender: AnyObject) {
        let data = ["name": taskSelect, "point": taskPoint,
                    "date": dateFomatter.string(from: Date())] as [String : Any]
        DBRef.child(userName).childByAutoId().setValue(data)
//        DBRef.childByAutoId().setValue(data)
        showAlert()
        print("タスク\(taskSelect)が選択されており、ポイントは\(taskPoint)です")

    }

    private func showAlert() {
        //UIAlertControllerのスタイルがalert
        let alert: UIAlertController = UIAlertController(title: "タスクを送信しました", message:  "お疲れさまでした", preferredStyle:  UIAlertController.Style.alert)
        // 確定ボタンの処理
        let confirmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // 確定ボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //実際の処理
            print("確定")
        })

        //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
        alert.addAction(confirmAction)

        //実際にAlertを表示する
        present(alert, animated: true, completion: nil)
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

    @IBAction private func tappedView(_ sender: Any) {
        print("Viewへのユーザータッチを検知")
        view.endEditing(true)
    }

    // 選択中のタスクをUIに更新
    private func setLabel(_ btText: String, _ point: Int) {
        let text = "\(btText)のボタンが選択されています"
        taskLabel.text = text
        taskSelect = btText
        taskPoint = point
    }
}

/// MARK - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Keyを指定して保存
        userDefaults.set(textField.text, forKey: "User")
        print("userDefaultsを更新")
        editingField = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

/// MARK - UICollectionViewDelegate
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        allUsers.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let user = allUsers[row]
        userTextField.text = user
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        allUsers[row]
    }
}
