//
//  RegisterViewController.swift
//  o_X
//
//  Created by Jason Brill on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

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
    
    
/*In the register view controller, add the necessary IBActions and IBOutlets to achieve the following behavior: when the register button is pressed, it should submit the entered username and password (in the text fields you have created) to the UserController singleton instance, via the register() method. Make sure to pass a closure as well, so that you can be notified of whether the registration was successful or whether it failed.
 
 If the registration fails (remember, we can know this by whether the User object in the callback was nil), present a helpful UIAlertController displaying the error message from the UserController, and with a single Dismiss action, that will simply allow the user to modify the text fields and try again.
 
 If the call succeeds (we can know this if the User object comes back as non-nil) then instantiate your Game Board storyboard and replace it as your app window’s root view controller.*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
