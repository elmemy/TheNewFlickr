//
//  customTextField.swift
//  yalabia
//
//  Created by ahmed tantawy on 8/22/19.
//  Copyright © 2019 ahmed tantawy. All rights reserved.
//

import UIKit
import Localize_Swift

class customTextField: UITextField {
    
    
    private var _arabicText = ""
    private var _englishText = ""
    private var _replacePlaceHolder = false
    
    
    @IBInspectable var arabicText : String {
        set(value){
            _arabicText = value
        }
        get {
            return _arabicText
        }
        
    }
    
    @IBInspectable var englishText : String  {
        set(value){
            _englishText = value
        }
        get{
            return _englishText
        }
    }
    
  
    
    @IBInspectable var replacePlaceHolder : Bool  {
        set(value){
            _replacePlaceHolder = value
        }
        get{
            return _replacePlaceHolder
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        if Localize.currentLanguage() == "ar"{
            let rightParagraphStyle = NSMutableParagraphStyle()
            rightParagraphStyle.alignment = .right
            let attributedPlaceholder = NSAttributedString(string: _arabicText, attributes: [NSAttributedString.Key.paragraphStyle: rightParagraphStyle])
            self.textAlignment = .right
            self.attributedPlaceholder = attributedPlaceholder
            
            let paddingView = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
            
            rightView = paddingView
            rightViewMode = .always
            
            if _replacePlaceHolder {
                self.text = _arabicText
            }
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
            
            
        }else if Localize.currentLanguage() == "en"{
            let leftParagraphStyle = NSMutableParagraphStyle()
            leftParagraphStyle.alignment = .left
            let attributedPlaceholder = NSAttributedString(string: _englishText, attributes: [NSAttributedString.Key.paragraphStyle: leftParagraphStyle])
            self.textAlignment = .left
            self.attributedPlaceholder = attributedPlaceholder
            
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
            
            rightView = paddingView
            rightViewMode = .always
            
            if _replacePlaceHolder {
                self.text = _englishText
                
            }
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
        }
//        self.font = UIFont(name: "JFFlat-regular", size: self.font!.pointSize)
        
        
    }
    
    
}





