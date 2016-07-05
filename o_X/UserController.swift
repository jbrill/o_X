//
//  UserController.swift
//  o_X
//
//  Created by Jason Brill on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation
import Alamofire

class UserController : WebService {
    static var sharedInstance:UserController = UserController()
    //private init() {}
    
    var currentLoggedInUser: User? //current logged in user
    
    func getLoggedInUser() -> User? {
        return currentLoggedInUser
    }
    
    private var userArray = [User]()
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void){
        print("HERE")
        let user = ["email" : email, "password" : password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        
        self.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if (responseCode / 100 == 2) {
                //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                
                let currUser = User(email: json["data"]["email"].stringValue, token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
                
                //and while we still at it, lets set the user as logged in. This is good programming as we are keeping all the user management inside the UserController and handling it at the right time
                self.currentLoggedInUser = currUser
                //Note that our registerUser function has 4 parameters: email, password, presentingViewController and requestCompletionFunction
                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the
                self.userArray.append(currUser)
                self.currentLoggedInUser = currUser
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                onCompletion(currUser,nil)
                return
                
            } else {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
                return
            }
            
        })
        
    }
    
    func login(email: String, password: String, onCompletion: (User?, String?) -> Void){
        let user = ["email" : email, "password" : password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth/sign_in"), method: "POST", parameters: user)
        
        self.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if (responseCode == 200) {
                //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
                let currUser = User(email: json["data"]["email"].stringValue, token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
                
                self.currentLoggedInUser = currUser
                let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(email, forKey: "currentUserEmail")
                    defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                onCompletion(currUser, nil)
                
                return
            } else {
                //the web service to create a user failed. Lets extract the error message to be displayed
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                //execute the closure in the ViewController
                onCompletion(nil,errorMessage)
                return
            }
        })
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserPassword")
        defaults.synchronize()
        
        currentLoggedInUser = nil;
        return
    }

}