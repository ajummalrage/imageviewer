//
//  ViewController.swift
//  Image Viewer
//
//  Created by Brian Dutremble on 9/12/15.
//  Copyright (c) 2015 Brian Dutremble. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePicker: UIImageView!
    
    @IBOutlet weak var useCamera: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
  
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.subscribeToKeyboardNotifications()
    
        
        let memeTextAttributes = [
            
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 60)!,
            NSStrokeWidthAttributeName : -2
        ]
        
        useCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        topTextField.text = "TOP"
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = self
        
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = self
    
    }
   
           func textFieldDidBeginEditing(textField: UITextField) {
            if textField.text == "TOP" || textField.text == "BOTTOM" {
                textField.text = " "
            }
        }
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true;
        }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    func setKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        if bottomTextField.editing {
            return keyboardSize.CGRectValue().height
        }
        else {
            return 0
    }
    }

    func keyboardWillShow(notification: NSNotification) {
            if bottomTextField.isFirstResponder(){
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder(){
            self.view.frame.origin.y += setKeyboardHeight(notification)
        }
    }
        func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
            func unsubscribeFromKeyboardNotifications() {
                NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
            }
    }
            override func viewDidAppear(animated: Bool){
                super.viewDidAppear(animated)
            

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
            }
    }
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
    @IBAction func openCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        }
}


