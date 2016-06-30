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
        return true;
    }
    return false;
}

func <(lhs: User, rhs: User) -> Bool {
    return lhs.email < rhs.email && lhs.password < rhs.password
}

func >(lhs: User, rhs: User) -> Bool {
    return lhs.email > rhs.email && lhs.password > rhs.password
}

func binarySearch(inputArr:[User], searchItem:User)->Int{
    var lowerIndex = 0;
    var upperIndex = inputArr.count - 1
    
    while (true) {
        let currentIndex = (lowerIndex + upperIndex)/2
        if(inputArr[currentIndex] == searchItem) {
            return currentIndex
        } else if (lowerIndex > upperIndex) {
            return -1
        } else {
            if (inputArr[currentIndex] > searchItem) {
                upperIndex = currentIndex - 1
            } else {
                lowerIndex = currentIndex + 1
            }
        }
    }
}

class UserController {
    static var sharedInstance:UserController = UserController();
    private init() {}
    
    var currentUser:User?;
    
    private var userArray = [User]();
    
    func sortUsers(var users:[User], tempUser:User!) -> [User]{
        for user in 0..<users.count{
            if(users[user] < tempUser){
                users.insert(tempUser, atIndex: Int(user))
                break;
            }
        }
        return users;
    }
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void){
        if (password.characters.count < 6){
            //ERROR MESSAGE
            onCompletion(nil, "Your password must be at least 6 characters.")
            return;
        }
        
        currentUser = User(email: email, password: password)
        onCompletion(currentUser, nil)
        userArray.append(currentUser!)
        sortUsers(userArray, tempUser: currentUser!);
    }
    
    func login(email: String, password: String, onCompletion: (User?, String?) -> Void){
        //let tempUser:User;
        currentUser!.email = email;
        currentUser!.password = password;
        if (binarySearch(userArray, searchItem: currentUser!) == -1){
            onCompletion(currentUser!, nil);
        } else {
            onCompletion(nil, nil)
            //ERROR MESSAGE
        }
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void){
        currentUser = nil;
    }

}