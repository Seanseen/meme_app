//
//  PhotoPickerDelegate.swift
//  meme_app
//
//  Created by tienhugn__ on 5/5/24.
//

import Foundation
import UIKit

protocol MemePhotoPickerBehavior: AnyObject {
    func didSelect(_ photo: UIImage)
}

class MemePhotoPickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var behavior: MemePhotoPickerBehavior?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage {
            behavior?.didSelect(img)
        }
        
        // Dismiss view after selected image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func isCameraAvalable() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
            return UIImagePickerController.isSourceTypeAvailable(.camera)
        #endif
    }
    
    func setUpController(_ sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = self
        return controller
    }
}

extension UIView {
    func generateMemedImage(_ toggleToolBar: (Bool) -> Void) -> UIImage {
        // Render view to an image
        toggleToolBar(false)
        
        UIGraphicsBeginImageContext(self.frame.size)
        self.drawHierarchy(in: self.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toggleToolBar(true)
        return memedImage
    }
}
