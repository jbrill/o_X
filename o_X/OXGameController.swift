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
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void){
        let dumArr:[OXGame] = []
        onCompletion(dumArr, "String")
        return
    }
}