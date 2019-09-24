//
//  ViewController.swift
//  techitter
//
//  Created by 南伊織 on 2018/09/15.
//  Copyright © 2018年 LifeisTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.returnKeyType = .done
        textField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.textField.isFirstResponder) {
            self.textField.resignFirstResponder()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toTableView") {
            let tvc: TableViewController = (segue.destination as? TableViewController)!
            if textField.text == ""{
                tvc.userName = "匿メンター"
            }else{
                tvc.userName = textField.text
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

