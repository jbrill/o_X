//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    var gameObject:OXGame = OXGame();
    var flag:Bool = false;
    
    @IBOutlet weak var UL: UIButton!
    @IBOutlet weak var UM: UIButton!
    @IBOutlet weak var UR: UIButton!
    @IBOutlet weak var MR: UIButton!
    
    @IBOutlet weak var MM: UIButton!
    
    @IBOutlet weak var ML: UIButton!
    @IBOutlet weak var LL: UIButton!
    @IBOutlet weak var LM: UIButton!
    @IBOutlet weak var LR: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        //print("New game button pressed.")
        gameObject.reset();
        let tempString:String = " ";
        LR.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        LM.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        LL.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        ML.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        MM.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        MR.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        UL.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        UM.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
        UR.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)
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
        
        sender.setAttributedTitle(NSAttributedString(string: tempString), forState: UIControlState.Normal)

        if(gameObject.state() == OXGameState.Won){
            print("Game won!");
        } else if (gameObject.state() == OXGameState.Tie){
            print("Game tied!")
        }
    }
    

}

