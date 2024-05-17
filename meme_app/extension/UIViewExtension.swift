//
//  UIViewExtension.swift
//  meme_app
//
//  Created by tienhugn__ on 17/5/24.
//

import UIKit

extension UIView {
    
    func initViewFromNIb<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        
        return contentView
    }
}
