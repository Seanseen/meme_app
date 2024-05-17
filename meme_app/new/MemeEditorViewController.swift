//
//  ViewController.swift
//  meme_app
//
//  Created by tienhugn__ on 5/5/24.
//

import UIKit

class MemeEditorViewController: UIViewController, MemePhotoPickerBehavior, MemeKeyboardBehavior {

    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var pickPhotoBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var centerImg: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var topAppBar: UIStackView!
    @IBOutlet weak var bottomAppBar: UIStackView!
    
    let photoDelegate = MemePhotoPickerDelegate()
    let keyboardDelegate = MemeKeyboardBehaviorDelegate()
    let topLabelDelegate = MemeTextFieldDelegate(defaultValue: "TOP")
    let bottomLabelDelegate = MemeTextFieldDelegate(defaultValue: "BOTTOM")
    
    /// LifeCycle methods
    override func viewWillAppear(_ animated: Bool) {
        takePhotoBtn.isEnabled = photoDelegate.isCameraAvalable()
        shareBtn.isEnabled = false
        keyboardDelegate.subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBehavior()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        keyboardDelegate.unsubscribeFromKeyboardNotifications()
    }
    
    /// Local methods
    private func initView() {
        initLabel()
    }
    
    private func initBehavior() {
        photoDelegate.behavior = self
        keyboardDelegate.behavior = self
    }
    
    private func initLabel() {
        topLabel.initAttribute(delegate: topLabelDelegate)
        bottomLabel.initAttribute(delegate: bottomLabelDelegate)
    }
    
    private func toggleToolBar(_ visible: Bool) {
        topAppBar.isHidden = !visible
        bottomAppBar.isHidden = !visible
    }
    
    private func save(_ meme: UIImage) {
        let meme = MemeObject(topLabel: topLabel.text!, bottomLabel: bottomLabel.text!, originalImage: centerImg.image!, memeImage: meme)
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }

    /// Integrated function
    @IBAction func takePhoto(_ sender: UIButton) {
        let sourceType: UIImagePickerController.SourceType = switch sender.tag {
            case ButtonSelected.LibraryButton.rawValue: .photoLibrary
            case ButtonSelected.CameraButton.rawValue: .camera
            default: .photoLibrary
        }
        present(photoDelegate.setUpController(sourceType), animated: true, completion: nil)
    }
    
    @IBAction func shareMemePhoto(_ sender: Any) {
        let meme = self.view.generateMemedImage(toggleToolBar)
        let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        controller.completionWithItemsHandler = {activity, success, items, error in
            if success {
                self.save(meme)
            }
        }
        controller.popoverPresentationController?.sourceView = self.view
        present(controller, animated: true, completion: nil)
    }
    
    /// Protocol implemented
    func didSelect(_ photo: UIImage) {
        centerImg.image = photo
        shareBtn.isEnabled = true
    }
    
    func keyboardWillShow(kbHeight: CGFloat) {
        if bottomLabel.isFirstResponder {
            view.frame.origin.y = kbHeight
        }
    }
    
    func keyboardWillHide(kbHeight: CGFloat) {
        view.frame.origin.y = kbHeight
    }
}

enum ButtonSelected: Int {
    case LibraryButton = 0
    case CameraButton = 1
}
