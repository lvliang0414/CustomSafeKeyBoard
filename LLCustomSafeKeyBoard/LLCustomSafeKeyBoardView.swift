//
//  LLCustomSafeKeyBoardView.swift
//  CustomSafeKeyBoard
//
//  Created by LVLIANG－MAC on 2017/5/3.
//  Copyright © 2017年 tenyearsdream. All rights reserved.
//

import UIKit

class LLCustomSafeKeyBoardView: UIView {

    var characterKeys = Array<UIButton>()        //字符键盘
    var numberKeys = Array<UIButton>()           //数字键盘
    
    var characterView: UIView?
    var numberView: UIView?
    
    var shiftButton: UIButton?
    var textView: UITextField?
    var isShifted: Bool = false
    
    let Char = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"]
    let CharShift = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"]
    let CharNumber = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    required init() {
        let frame = CGRect(x: 0, y: 0, width: UIUtils.getScreenWidth(), height: 200)
        super.init(frame: frame)

        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func createView() -> Void {
        makeCharacterKeyboard()
        makeNumberKeyboard()
        self.numberView!.isHidden = true
    }
    
    func makeCharacterKeyboard() -> Void {
        
        
        self.characterView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIUtils.getScreenWidth(), height: 200))
        self.characterView!.backgroundColor = UIUtils.getMainBgColor()
        self.addSubview(self.characterView!)
        
        let interval:CGFloat = 2;
        let space = UIUtils.getScreenWidth() / 10.0
        let top:CGFloat = 10
        let vspace:CGFloat = 10
        let height:CGFloat = 40
        
        //第一行字符
        for i in 0...9 {
            let btn = UIButton.init(frame: CGRect(x: space * CGFloat(i) + interval, y: top, width: space - CGFloat(2) * interval, height: height))
            btn.backgroundColor = UIUtils.getButtonColor();
            btn.tag = i
            btn.addTarget(self, action:#selector(characterPressed(_:)), for:.touchUpInside)
            self.characterView!.addSubview(btn)
            self.characterKeys.append(btn)
        }
        
        let margin:CGFloat = space / 2;
        //第2行字符
        for i in 0...8 {
            let btn = UIButton.init(frame: CGRect(x: margin + space * CGFloat(i) + interval, y: top + height + vspace, width: space - CGFloat(2) * interval, height: height))
            btn.backgroundColor = UIUtils.getButtonColor();
            btn.tag = i + 10
            btn.addTarget(self, action:#selector(characterPressed(_:)), for:.touchUpInside)
            self.characterView!.addSubview(btn)
            self.characterKeys.append(btn)
        }
        //第3行字符
        for i in 0...7 {
            let btn = UIButton.init(frame: CGRect(x: margin + space * CGFloat(i) + interval, y: top + (height + vspace) * CGFloat(2), width: space - CGFloat(2) * interval, height: height))
            btn.backgroundColor = UIUtils.getButtonColor();
            btn.tag = i + 18
            btn.addTarget(self, action:#selector(characterPressed(_:)), for:.touchUpInside)
            self.characterView!.addSubview(btn)
            self.characterKeys.append(btn)
        }
        
        for b in self.characterKeys {
            b.setTitle(Char[b.tag], for: .normal)
            b.setTitleColor(UIUtils.getTextColor(), for: .normal)
            b.titleLabel?.font = UIUtils.getTextFont()
        }
        
        //Shift
        let shiftBtn = UIButton.init(frame: CGRect(x: interval, y: top + (height + vspace) * CGFloat(2), width: space + margin - CGFloat(2) * interval, height: height))
        shiftBtn.backgroundColor = UIUtils.getButtonColor()
        self.characterView!.addSubview(shiftBtn)
        shiftBtn.setTitle("Shift", for: .normal)
        shiftBtn.setTitleColor(UIUtils.getTextColor(), for: .normal)
        shiftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        shiftBtn.addTarget(self, action: #selector(shiftPressed), for: .touchUpInside)
        self.shiftButton = shiftBtn
        
        //Delete
        let delBtn = UIButton.init(frame: CGRect(x: interval + space * CGFloat(8) + margin, y: top + (height + vspace) * CGFloat(2), width: space + margin - CGFloat(2) * interval, height: height))
        delBtn.backgroundColor = UIUtils.getButtonColor()
        self.characterView!.addSubview(delBtn)
        delBtn.setTitle("Del", for: .normal)
        delBtn.setTitleColor(UIUtils.getTextColor(), for: .normal)
        delBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        delBtn.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        
        //123
        let numberBtn = UIButton.init(frame: CGRect(x: interval, y: top + (height + vspace) * CGFloat(3), width: space * CGFloat(2) + margin - CGFloat(2) * interval, height: height))
        numberBtn.backgroundColor = UIUtils.getButtonColor()
        numberBtn.setTitle("123", for: .normal)
        numberBtn.titleLabel?.font = UIUtils.getTextFont()
        numberBtn.tag = 0
        numberBtn.addTarget(self, action: #selector(switchKeyboardPressed(_:)), for: .touchUpInside)
        self.addSubview(numberBtn)
        
        //Text
        let spaceBtn = UIButton.init(frame: CGRect(x: interval + space * CGFloat(2) + margin, y: top + (height + vspace) * CGFloat(3), width: space * CGFloat(5) - CGFloat(2) * interval, height: height))
        spaceBtn.backgroundColor = UIUtils.getButtonColor()
        spaceBtn.setTitle("安全键盘", for: .normal)
        spaceBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        spaceBtn.tag = 0
        self.addSubview(spaceBtn)
        
        //Done
        let doneBtn = UIButton.init(frame: CGRect(x: interval + space * CGFloat(7) + margin, y: top + (height + vspace) * CGFloat(3), width: space * CGFloat(2) + margin - CGFloat(2) * interval, height: height))
        doneBtn.backgroundColor = UIUtils.getButtonColor()
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.titleLabel?.font = UIUtils.getTextFont()
        doneBtn.tag = 0
        doneBtn.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
        self.addSubview(doneBtn)
    }
    
    func makeNumberKeyboard() -> Void {
        
        
        self.numberView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIUtils.getScreenWidth(), height: 200))
        self.addSubview(self.numberView!)
        self.numberView!.backgroundColor = UIUtils.getMainBgColor()
        
        let interval:CGFloat = 2
        let space:CGFloat = UIUtils.getScreenWidth() / 3;
        let top:CGFloat = 10
        let vspace:CGFloat = 10
        let height:CGFloat = 40

        for i in 0...9 {
            let row:CGFloat = CGFloat(i / 3);
            let col:CGFloat = CGFloat(i % 3);
            let btn = UIButton.init(frame: CGRect(x: space * col + interval, y: top + (height + vspace) * row, width: space - CGFloat(2) * interval, height: height))
            btn.backgroundColor = UIUtils.getButtonColor()
            btn.setTitle(CharNumber[i], for: .normal)
            btn.setTitleColor(UIUtils.getTextColor(), for: .normal)
            btn.titleLabel?.font = UIUtils.getNumberFont()
            btn.tag = i
            btn.addTarget(self, action: #selector(characterPressed(_ :)), for: .touchUpInside)
            self.numberView!.addSubview(btn)
            self.numberKeys.append(btn)
        }
        
        //ABC
        let abcBtn = UIButton.init(frame: CGRect(x: interval, y: top + (height + vspace) * CGFloat(3), width: space - CGFloat(2) * interval, height: height))
        abcBtn.backgroundColor = UIUtils.getButtonColor()
        abcBtn.setTitle("ABC", for: .normal)
        abcBtn.setTitleColor(UIUtils.getTextColor(), for: .normal)
        abcBtn.titleLabel?.font = UIUtils.getNumberFont()
        abcBtn.tag = 1
        abcBtn.addTarget(self, action: #selector(switchKeyboardPressed(_:)), for: .touchUpInside)
        self.numberView!.addSubview(abcBtn)
        
        //0
        let zeroBtn = UIButton.init(frame: CGRect(x: space + interval, y: top + (height + vspace) * CGFloat(3), width: space - CGFloat(2) * interval, height: height))
        zeroBtn.backgroundColor = UIUtils.getButtonColor()
        zeroBtn.setTitle("0", for: .normal)
        zeroBtn.setTitleColor(UIUtils.getTextColor(), for: .normal)
        zeroBtn.titleLabel?.font = UIUtils.getNumberFont()
        zeroBtn.tag = 9
        zeroBtn.addTarget(self, action: #selector(characterPressed(_:)), for: .touchUpInside)
        self.numberView!.addSubview(zeroBtn)
        self.numberKeys.append(zeroBtn)
        
        //Delete
        let delBtn = UIButton.init(frame: CGRect(x: space * CGFloat(2) + interval, y: top + (height + vspace) * CGFloat(3), width: space - CGFloat(2) * interval, height: height))
        delBtn.backgroundColor = UIUtils.getButtonColor()
        delBtn.setTitle("Del", for: .normal)
        delBtn.setTitleColor(UIUtils.getTextColor(), for: .normal)
        delBtn.titleLabel?.font = UIUtils.getNumberFont()
        delBtn.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        self.numberView!.addSubview(delBtn)
        
        self.setRandomNumber()
    }

    func characterPressed(_ button:UIButton) -> Void {
        let character = button.titleLabel?.text
        self.textView?.insertText(character!)
        NotificationCenter.default.post(name: .UITextFieldTextDidChange, object: self.textView!)
    }
    
    func shiftPressed() -> Void {
        self.isShifted = !self.isShifted
        self.updateCharacterShift()
        
        if (self.isShifted) {
            self.shiftButton?.setTitleColor(UIColor.black, for: .normal)
            self.shiftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        else {
            self.shiftButton?.setTitleColor(UIColor.white, for: .normal)
            self.shiftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
    }
    
    func deletePressed() -> Void {
        UIDevice.current.playInputClick()
        self.textView?.deleteBackward()
        NotificationCenter.default.post(name: .UITextFieldTextDidChange, object: self.textView!)
    }
    
    func switchKeyboardPressed(_ btn:UIButton) -> Void {
        if (btn.tag == 0) {
            self.characterView?.isHidden = true
            self.numberView?.isHidden = false
        }
        else {
            self.characterView?.isHidden = false
            self.numberView?.isHidden = true
        }
    }
    
    func enterPressed() -> Void {
        textView?.resignFirstResponder()
    }
    
    func updateCharacterShift() -> Void {
        for b in self.characterKeys {
            if (self.isShifted) {
                b.setTitle(CharShift[b.tag], for: .normal)
            }
            else {
                b.setTitle(Char[b.tag], for: .normal)
            }
        }
    }
    
    func setRandomNumber() -> Void {
        let arry = self.CharNumber.sorted(by: { (str1, str2) -> Bool in
            let seed = arc4random_uniform(2)
            if (seed != 0 ) {
                return true
            }
            else {
                return false
            }
        })
        
        var index:Int = 0
        for str in arry {
            let btn = self.numberKeys[index]
            btn.setTitle(str, for: .normal)
            index = index + 1
        }
        
    }
    
    func setInputTextView(_ textView:UITextField) -> Void {
        textView.inputView = self
        self.textView = textView
    }
    
}
