//
//  RegisterViewController.swift
//  o_X
//
//  Created by Jason Brill on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        let uc = UserController.sharedInstance
        
        uc.register(emailInput.text!, password: passwordInput.text!) { user, message in
            if user == nil {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle:  UIAlertControllerStyle.Alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        passwordInput.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
