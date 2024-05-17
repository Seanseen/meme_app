//
//  KeyboardBehaviorDelegate.swift
//  meme_app
//
//  Created by tienhugn__ on 5/5/24.
//

import Foundation
import UIKit

@objc protocol MemeKeyboardBehavior: AnyObject {
    @objc func keyboardWillShow(kbHeight: CGFloat)
    @objc func keyboardWillHide(kbHeight: CGFloat)
}

class MemeKeyboardBehaviorDelegate {
    
    weak var behavior: MemeKeyboardBehavior?
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("keyboardWillShow")
        behavior?.keyboardWillShow(kbHeight: getKeyboardHeight(notification) * (-1))
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide")
        behavior?.keyboardWillHide(kbHeight: 0)
    }
    
    func subscribeToKeyboardNotifications() {
        print("subscribeToKeyboardNotifications")
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        print("unsubscribeToKeyboardNotifications")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
