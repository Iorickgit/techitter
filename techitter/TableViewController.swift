//
//  TableViewController.swift
//  techitter
//
//  Created by 南伊織 on 2018/09/15.
//  Copyright © 2018年 LifeisTech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var userName: String!
    var tableCellNumber: Int!
    var postArray: [String] = []
    var userIdArray: [String] = []
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var postTextField: UITextField!
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        update()
        
        //tableView周り
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //投稿周り
        postTextField.delegate = self
        postTextField.returnKeyType = .send
        postTextField.placeholder = "Whats going on?"
        
        //ハンドルネーム周り
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.text = userName
        // Do any additional setup after loading the view.
    }
    
    func post(){
        self.ref.child("postID").childByAutoId().setValue(["username": userNameLabel.text,"post": postTextField.text])
        postTextField.text = ""
        postTextField.placeholder = "Whats going on?"
    }
    
    //投稿の最適化
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        post()
        return true
    }
    
    //投稿ボタンの実装
    @IBAction func send(){
        post()
    }
    
    //更新ボタンの実装
    func update(){
        self.ref?.child("postID").observe(.childAdded, with: { [weak self](snapshot) -> Void in
            self?.userIdArray.append(String(describing: snapshot.childSnapshot(forPath: "username").value!))
            self?.postArray.append(String(describing: snapshot.childSnapshot(forPath: "post").value!))
            
            // ここでtableviewなどの更新を行う
            self?.tableView.reloadData()
        })
    }

    //外部タッチ時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.postTextField.isFirstResponder) {
            self.postTextField.resignFirstResponder()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userIdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.labelAdd(indexPathNum: indexPath, username: userIdArray, post: postArray)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
