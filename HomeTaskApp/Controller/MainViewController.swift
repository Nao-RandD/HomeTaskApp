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

    @IBOutlet var taskButtonCollection: [UIButton]!

    private var userPickerView: UIPickerView!
    private var editingField: UITextField?

    private var taskSelect = ""
    private var taskPoint = 0
    private let dateFomatter = DateFormatter()
    private var userName = ""
    private let allUsers = User.allCases.map { $0.name }

    private var taskList = ["洗濯入れ", "洗濯出し", "食器入れ", "食器出し" ]
    private var pointList = [1, 3, 2, 3]

    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    // インスタンス変数
    var DBRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFomatter.dateFormat = "yyyy/MM/dd"
        setButton()

        DBRef = Database.database().reference()
        userDefaults.register(defaults: ["User": allUsers[0]])

        userTextField.delegate = self
        // categoryPickerViewを設定
        userPickerView = UIPickerView()
        userPickerView.delegate = self
        userPickerView.dataSource = self
        userTextField.inputView = userPickerView
    }

    override func viewWillAppear(_ animated: Bool) {
        userTextField.text = userDefaults.object(forKey: "User") as? String
        userName = userDefaults.object(forKey: "User") as? String ?? allUsers[0]
    }

    @IBAction func add(_ sender: AnyObject) {
        let data = ["name": taskSelect, "point": taskPoint,
                    "date": dateFomatter.string(from: Date())] as [String : Any]
//        DBRef.childByAutoId().setValue(data)
        DBRef.child(self.userName).childByAutoId().setValue(data)
//        showAlert(data: data)
        showSuccessAlert()
        print("タスク\(taskSelect)が選択されており、ポイントは\(taskPoint)です")
    }

    @IBAction func tapButton1(_ sender: Any) {
        setLabel(taskList[0], pointList[0])
    }

    @IBAction func tapButton2(_ sender: Any) {
        setLabel(taskList[1], pointList[1])
    }

    @IBAction func tapButton3(_ sender: Any) {
        setLabel(taskList[2], pointList[2])
    }

    @IBAction func tapButton4(_ sender: Any) {
        setLabel(taskList[3], pointList[3])
    }

    @IBAction private func tappedView(_ sender: Any) {
        print("Viewへのユーザータッチを検知")
        view.endEditing(true)
    }
}

/// MARK - Private function
extension MainViewController {
    private func setButton() {
        var i = 0
        for task in taskList {
            taskButtonCollection[i].setTitle(task, for: .normal)
            i += 1
        }
    }

    // 選択中のタスクをUIに更新
    private func setLabel(_ btText: String, _ point: Int) {
        let text = "\(btText)は\(point)ポイントです"
        taskLabel.text = text
        taskSelect = btText
        taskPoint = point
    }

//    private func showAlert(data: [String: Any]) {
//        let alert = UIAlertController(title: "送信するタスクの確認",
//                                      message:  "\(userName)として\(data["name"] ?? "")のタスクを送信します",
//                                      preferredStyle:  UIAlertController.Style.alert)
//
//        let confirmAction = UIAlertAction(title: "送信",
//                                          style: UIAlertAction.Style.default,
//                                          handler: {
//                                            (action: UIAlertAction!) -> Void in
//                                            defer {
//                                                self.showSuccessAlert()
//                                            }
//                                            self.DBRef.child(self.userName).childByAutoId().setValue(data)
//        })
//        let cancelAction = UIAlertAction(title: "キャンセル",
//                                         style: UIAlertAction.Style.cancel,
//                                         handler:{
//                                            (action: UIAlertAction!) -> Void in
//        })
//
//        alert.addAction(confirmAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true, completion: nil)
//    }

    private func showSuccessAlert() {
        let alert = UIAlertController(title: "タスクの送信完了",
                                      message:  "お疲れさまでした",
                                      preferredStyle:  UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: {
                                            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
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
