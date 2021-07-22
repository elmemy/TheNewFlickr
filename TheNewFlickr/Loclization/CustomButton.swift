//
//  CustomButton.swift
//  yalabia
//
//  Created by ahmed tantawy on 8/22/19.
//  Copyright © 2019 ahmed tantawy. All rights reserved.
//

import UIKit
import Localize_Swift

class CustomButton: UIButton {
    
    private var _arabicText  = ""
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
        
        if Localize.currentLanguage() == "ar"{
            self.setTitle(_arabicText, for: .normal)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
        }else if Localize.currentLanguage() == "en"{
            self.setTitle(_englishText, for: .normal)
            self.titleEdgeInsets.left = self.titleEdgeInsets.right
            self.titleEdgeInsets.right = 0
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
//        self.titleLabel?.font = UIFont(name: "JFFlat-regular", size: self.titleLabel!.font.pointSize)
    }
    
    
    
}

extension String {
    
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self.localized(), attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
}




import UIKit
import Localize_Swift

class CustomBackButton {
    
    static func BackButton(back:UIButton){
    
        if Localize.currentLanguage() == "en" {
            back.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }
    }
}
