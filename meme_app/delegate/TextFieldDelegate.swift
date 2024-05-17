//
//  CustomTextFieldDelegate.swift
//  meme_app
//
//  Created by tienhugn__ on 5/5/24.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var defaultValue: String = ""
    
    init(defaultValue: String) {
        self.defaultValue = defaultValue
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        let text = textField.text
        if text == defaultValue {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        let text = textField.text
        if text == nil || text == "" {
            textField.text = defaultValue
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    func getDefaultValue() -> String {
        return defaultValue
    }
   
}

extension UITextField {
    var memeTxtAttributes: [NSAttributedString.Key: Any] {
        get {
            return [
                NSAttributedString.Key.strokeColor : UIColor.black,
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "Impact", size: 45)!,
                NSAttributedString.Key.strokeWidth : NSNumber(value: -3.0 as Float),
            ]
        }
    }
    
    func initAttribute(delegate: MemeTextFieldDelegate) {
        self.delegate = delegate
        self.text = delegate.getDefaultValue()
        self.defaultTextAttributes = memeTxtAttributes
        self.textAlignment = .center
        self.backgroundColor = .clear
        self.borderStyle = .none
        self.minimumFontSize = 10
        self.adjustsFontSizeToFitWidth = true
        self.sizeToFit()
    }
}
