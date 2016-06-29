//
//  OXGame.swift
//  o_X
//
//  Created by Jason Brill on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

enum CellType : String {
    case O = "O";
    case X = "X";
    case Empty = "";
}

enum OXGameState {
    case InProgress;
    case Tie;
    case Won;
}


class OXGame{
    func turnCount() -> Int{
        counter += 1;
        return counter;
    }
    
    func whoseTurn() -> CellType{
        if (counter % 2 == 0){
            return CellType.X;
        } else {
            return CellType.O;
        }
    }
    
    func playMove(move_:Int) -> CellType{
        board[move_] = whoseTurn();
        return board[move_];
    }
    
    func gameWon() -> Bool {
        //TODO
        //checking horizontals
        if((board[0] == board[1] && board[1] == board[2] && board[0] != CellType.Empty) || (board[3] == board[4] && board[4] == board[5] && board[3] != CellType.Empty) || (board[6] == board[7] && board[7] == board[8] && board[6] != CellType.Empty)){
            print("HERE2")
            return true;
        }
        //checking verticals
        if((board[0] == board[3] && board[3] == board[6] && board[0] != CellType.Empty) || (board[1] == board[4] && board[4] == board[7] && board[1] != CellType.Empty) || (board[2] == board[5] && board[5] == board[8] && board[2] != CellType.Empty)){
            print("HERE1")
            return true;
        }
        //checking diags
        if((board[0] == board[4] && board[4] == board[8] && board[0] != CellType.Empty) || (board[2] == board[4] && board[4] == board[6] && board[2] != CellType.Empty)){
            print("HERE")
            return true;
        }
        return false;
    }
    
    func state() -> OXGameState {
        gameWon();
        if(gameWon()){
            return OXGameState.Won;
        }
        if(counter == 9 && !gameWon()){
            return OXGameState.Tie;
        }
        return OXGameState.InProgress;
    }
    
    func reset(){
        //TODO: RESET BOARD
        for i in 0 ..< board.count {
            board[i] = CellType.Empty;
        }
        
        //print("HERBE")
        counter = 0;
    }
    
    var counter:Int = 0;
    var board = [CellType](count: 9, repeatedValue: CellType.Empty)
}
