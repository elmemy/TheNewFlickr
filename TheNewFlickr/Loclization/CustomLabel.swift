//
//  CustomLabel.swift
//  yalabia
//
//  Created by ahmed tantawy on 8/22/19.
//  Copyright © 2019 ahmed tantawy. All rights reserved.
//

import UIKit
import Localize_Swift

@IBDesignable
class CustomLabel: UILabel {
    
    
    private var _arabicText = ""
    private var _englishText = ""
    
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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        if let lang = getLang() {
        //            HomeViewController.myLang = lang
        //        }
        //        if HomeViewController.myLang == "ar" {
        //            self.text = _arabicText
        //            if self.textAlignment != .center {
        //                self.textAlignment = .right
        //            }
        
        if Localize.currentLanguage() == "ar"{
            
            self.text = _arabicText
            if self.textAlignment != .center {
                self.textAlignment = .right
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                
            }
            //
        }else if Localize.currentLanguage() == "en"{
            self.text = _englishText
            if self.textAlignment != .center {
                self.textAlignment = .left
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                
            }
        }
        
//        self.font = UIFont(name: "JFFlat-regular", size: self.font.pointSize)
    }
    
}
