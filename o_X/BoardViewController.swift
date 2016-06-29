//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    var gameObject:OXGameController = OXGameController();
    var flag:Bool = false;
    
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func cancelGame(){
        for subview in boardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle(" ", forState: .Normal)
            }
        }
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        //print("New game button pressed.")
        gameObject.restartGame();
        
        cancelGame();
        
        flag = false;
    }
    
    // Create additional IBActions here.
    @IBAction func boardTapped(sender: UIButton) {
        if(gameObject.getCurrentGame().state() != OXGameState.InProgress && flag == true){
            print("The game is over. please press new game.")
            return;
        }
        
        flag = true;
        let temp:CellType = gameObject.playMove(sender.tag);
        var tempString:String = "";
        
        if(temp == CellType.X){
            tempString = "X";
        } else if (temp == CellType.O){
            tempString = "O";
        }
        
        sender.setTitle(tempString, forState: .Normal)

        if(gameObject.getCurrentGame().state() == OXGameState.Won){
            print("Game won!");
        } else if (gameObject.getCurrentGame().state() == OXGameState.Tie){
            print("Game tied!")
        }
    }
    

}

