//
//  OXGame.swift
//  o_X
//
//  Created by Jason Brill on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//
import UIKit
import Foundation

enum CellType : String {
    case O = "O"
    case X = "X"
    case Empty = ""
}

enum OXGameState {
    case InProgress
    case Tie
    case Won
}


class OXGame{
    func turnCount() -> Int{
        counter += 1
        return counter
    }
    
    func whoseTurn() -> CellType{
        if (counter % 2 == 0){
            return CellType.X
        } else {
            return CellType.O
        }
    }
    
    func playMove(move_:Int) -> CellType{
        if(board[move_] == CellType.Empty){
            board[move_] = whoseTurn()
            return board[move_]
        } else {
            return board[move_]
        }
    }
    
    func getMove(move_:Int) ->CellType{
        return board[move_]
    }
    
    func gameWon() -> Bool {
        //TODO
        //checking horizontals
        if((board[0] == board[1] && board[1] == board[2] && board[0] != CellType.Empty) || (board[3] == board[4] && board[4] == board[5] && board[3] != CellType.Empty) || (board[6] == board[7] && board[7] == board[8] && board[6] != CellType.Empty)){
            return true
        }
        //checking verticals
        if((board[0] == board[3] && board[3] == board[6] && board[0] != CellType.Empty) || (board[1] == board[4] && board[4] == board[7] && board[1] != CellType.Empty) || (board[2] == board[5] && board[5] == board[8] && board[2] != CellType.Empty)){
            return true
        }
        //checking diags
        if((board[0] == board[4] && board[4] == board[8] && board[0] != CellType.Empty) || (board[2] == board[4] && board[4] == board[6] && board[2] != CellType.Empty)){
            return true
        }
        return false
    }
    
    func state() -> OXGameState {
        gameWon()
        if(gameWon()){
            return OXGameState.Won
        }
        if(counter == 8 && !gameWon()){
            return OXGameState.Tie
        }
        return OXGameState.InProgress
    }
    
    func reset(){
        for i in 0 ..< board.count {
            board[i] = CellType.Empty
        }
        counter = 0
    }
    
    var counter:Int = 0
    var board = [CellType](count: 9, repeatedValue: CellType.Empty)
    var ID: Int = 0;
    var host: String = "";
}
