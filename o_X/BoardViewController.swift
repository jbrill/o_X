//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    var gameObject:OXGame = OXGame();
    var flag:Bool = false;
    
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        //print("New game button pressed.")
        gameObject.reset();
        
        for subview in boardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle(" ", forState: .Normal)
            }
        }
        
        flag = false;
    }
    
    // Create additional IBActions here.
        @IBAction func boardTapped(sender: UIButton) {
        if(gameObject.state() != OXGameState.InProgress && flag == true){
            print("The game is over. please press new game.")
            return;
        }
        
        flag = true;
        gameObject.turnCount();
        let temp:CellType = gameObject.playMove(sender.tag);
        var tempString:String = "";
        if(temp == CellType.X){
            tempString = "X";
        } else if (temp == CellType.O){
            tempString = "O";
        }
        
        sender.setTitle(tempString, forState: .Normal)

        if(gameObject.state() == OXGameState.Won){
            print("Game won!");
        } else if (gameObject.state() == OXGameState.Tie){
            print("Game tied!")
        }
    }
    

}

