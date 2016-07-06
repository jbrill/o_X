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
    
    var currentLoggedInUser: User? //current logged in user
    
    func getLoggedInUser() -> User? {
        return currentLoggedInUser
    }
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void){
        //print("HERE")
        let user = ["email" : email, "password" : password]
        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
        
        self.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if (responseCode / 100 == 2) {
                let currUser = User(email: json["data"]["email"].stringValue, token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
                
                self.currentLoggedInUser = currUser
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(currUser.email, forKey: "currentUserEmail")
                defaults.setObject(currUser.token, forKey: "currentUserToken")
                defaults.setObject(currUser.client, forKey: "currentUserClient")
                defaults.synchronize()
                
                onCompletion(currUser,nil)
                return
            } else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                
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
                let currUser = User(email: json["data"]["email"].stringValue, token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
                
                self.currentLoggedInUser = currUser
                
                ////////////PERSISTING USER////////////////
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(currUser.email, forKey: "currentUserEmail")
                //defaults.setObject(password, forKey: "currentUserPassword")
                defaults.setObject(currUser.token, forKey: "currentUserToken")
                defaults.setObject(currUser.client, forKey: "currentUserClient")
                defaults.synchronize()
                
                
                
                onCompletion(currUser, nil)
                
                return
            } else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue

                onCompletion(nil,errorMessage)
                return
            }
        })
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserToken")
        defaults.stringForKey("currentUserClient")
        defaults.synchronize()
        
        currentLoggedInUser = nil;
        return
    }

}