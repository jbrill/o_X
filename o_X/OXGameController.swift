//
//  OXGameController.swift
//  o_X
//
//  Created by Jason Brill on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation
import Alamofire

class OXGameController : WebService {
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
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        let request = createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if (responseCode / 100 == 2) {
                var myGames: [OXGame] = []

                for game in json.arrayValue {
                    let tempGame = OXGame(board: game["host_user"]["name"].stringValue, id: game["host_user"]["id"].stringValue, host: game["host_user"]["name"].stringValue)
                    myGames.append(tempGame)
                }
            
                onCompletion(myGames, nil)
                return
            } else {
                //print("bad response code")
                onCompletion(nil, "Could not load games.")
                return
            }
            
        })
    }
}