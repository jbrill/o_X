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
    case Open
    case Abandoned  
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
    var ID: String = "";
    var host: String = "";
    
    private func deserialiseBoard(stringin:String) -> [CellType]{
        for char in 0..<stringin.characters.count {
            let index = stringin.startIndex.advancedBy(char)
            //print("HERE AT \(index)")
            if(stringin.characters[index] == "X" || stringin.characters[index] == "x"){
                board[char] = CellType.X
            } else if (stringin.characters[index] == "O" || stringin.characters[index] == "o"){
                board[char] = CellType.O
            } else {
                board[char] = CellType.Empty
            }
        }
        return board;
    }
    
    private func serialiseBoard() -> String {
        var myString:String = ""
        for char in 0..<board.count {
            let index = board.startIndex.advancedBy(char)
            //print("HERE AT \(board[index])")
            if(board[index] == CellType.X){
                myString.append("x" as Character)
            } else if (board[index] == CellType.O){
                myString.append("o" as Character)
            } else {
                myString.append("_" as Character)
            }
        }
        return myString;
    }
    
    init()
        {}
    
    init(board: String, id: String, host: String){
        self.board = deserialiseBoard(board)
        self.ID = id
        self.host = host
        //we are simulating setting our board from the internet
//        let simulatedBoardStringFromNetwork = "_________" //update this string to different values to test your model serialisation
//        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
//        print(serialiseBoard())
//        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
//            print("start\n------------------------------------")
//            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
//            
//            print("done\n------------------------------------")
//        }   else    {
//            print("start\n------------------------------------")
//            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
//            
//            print("done\n------------------------------------")
//        }
        
    }
}
