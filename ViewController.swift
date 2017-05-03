//
//  ViewController.swift
//  CustomSafeKeyBoard
//
//  Created by LVLIANG－MAC on 2017/5/3.
//  Copyright © 2017年 tenyearsdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let customKeyboard = LLCustomSafeKeyBoardView()
        
        customKeyboard.setInputTextView(inputTextField);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

