//
//  OXGameController.swift
//  o_X
//
//  Created by Jason Brill on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGameController {
    static var sharedInstance = OXGameController()
    
    private var currentGame:OXGame = OXGame();
    
    func getCurrentGame() -> OXGame {
        return currentGame;
    }
    
    func restartGame(){
        currentGame.reset();
    }
    
    func playMove(tag_:Int) -> CellType{
        currentGame.turnCount();
        let temp:CellType = currentGame.playMove(tag_);
        return temp;
    }
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) -> [OXGame]?{
        //let user = ["email" : email, "password" : password]
//        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: user)
//        
//        self.executeRequest(request, requestCompletionFunction: {responseCode, json in
//            if (responseCode == 200) {
//                //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
//                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
//                let currUser = self.createUser(json["data"]["email"].stringValue, password:"not_given_and_not_stored", token: json["data"]["token"].stringValue, client: json["data"]["client"].stringValue)
//                
//                for user in self.userArray{
//                    if(user == currUser){
//                        onCompletion(currUser, nil)
//                        self.currentLoggedInUser = currUser
//                        let defaults = NSUserDefaults.standardUserDefaults()
//                        defaults.setObject(self.currentLoggedInUser?.email, forKey: "currentUserEmail")
//                        defaults.setObject(self.currentLoggedInUser?.password, forKey: "currentUserPassword")
//                        defaults.synchronize()
//                    }
//                }
//                
//                return
//            } else {
//                //the web service to create a user failed. Lets extract the error message to be displayed
//                let errorMessage = json["errors"]["full_messages"][0].stringValue
//                //execute the closure in the ViewController
//                onCompletion(nil,errorMessage)
//                return
//            }
//        }
        
        let dumArr:[OXGame] = []
        onCompletion(dumArr, nil)
        return dumArr
    }
}