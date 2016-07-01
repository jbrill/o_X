//
//  UserController.swift
//  o_X
//
//  Created by Jason Brill on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

func ==(lhs: User, rhs: User) -> Bool {
    if (lhs.email == rhs.email && rhs.password == lhs.password){
        return true
    }
    return false
}

class UserController {
    static var sharedInstance:UserController = UserController()
    private init() {}
    
    var currentLoggedInUser: User? //current logged in user
    
    func createUser(email: String, password: String) -> User{
        let currentUser: User = User(email: email, password: password)
        return currentUser
    }
    
    private var userArray = [User]()
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void){
        let currUser: User = createUser(email, password: password)
        
        if (currUser.password.characters.count < 6){
            //ERROR MESSAGE
            onCompletion(nil, "Your password must be at least 6 characters.")
            return
        }
        
        /*for user in userArray{
            if(user == currUser){
                onCompletion(nil, "You already have an account!")
                return
            }
        }*/
        
        userArray.append(currUser)
        currentLoggedInUser = currUser
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(currentLoggedInUser?.email, forKey: "currentUserEmail")
        defaults.setObject(currentLoggedInUser?.password, forKey: "currentUserPassword")
        defaults.synchronize()
        
        onCompletion(currUser, nil)
        return
    }
    
    func login(email: String, password: String, onCompletion: (User?, String?) -> Void){
        let currUser: User = createUser(email, password: password)
        
        for user in userArray{
            if(user == currUser){
                onCompletion(currUser, nil)
                currentLoggedInUser = currUser
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(currentLoggedInUser?.email, forKey: "currentUserEmail")
                defaults.setObject(currentLoggedInUser?.password, forKey: "currentUserPassword")
                defaults.synchronize()
                return
            }
        }
        
        onCompletion(nil, nil)
        return
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentUserEmail")
        defaults.synchronize()
        
        currentLoggedInUser = nil;
        return
    }

}