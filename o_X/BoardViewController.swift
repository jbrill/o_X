//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    var gameObject:OXGameController = OXGameController();
    var flag:Bool = false;
    var networkMode:Bool = false;
    
    @IBOutlet weak var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        newGameButton.hidden = true
        //if(networkMode){
            updateUI()
        //}
    }
    
    func cancelGame(){
        for subview in boardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle(" ", forState: .Normal)
            }
        }
    }
    
    
    /*
     * BoardViewController's updateUI() function
     * Although we haven't completed full network functionality yet,
     * this function will come in handy when we have to display our opponents moves
     * that we obtain from the networking layers (more on that later)
     * For now, you are required to implement this function in connection with Activity 1 from todays class
     * Hint number 1: This function must set the values of O and X on the board, based on the games board array values. Does this kind of remind you of the resetBoard or newGameTapped function???
     * Hint number 2: if you set your board array to private in the OXGame class, maybe you should set it now to 'not private' ;)
     * Hint number 3: call this function in BoardViewController's viewDidLoad function to see it execute what board was set in the game's initialiser on your screen!
     * And Go!
     */
    func updateUI() {
        for subview in 0..<boardView.subviews.count {
            if let button = boardView.subviews[subview] as? UIButton {
                
                if(gameObject.getCurrentGame().board[button.tag] == CellType.X){
                    button.setTitle("X", forState: .Normal)
                } else if (gameObject.getCurrentGame().board[button.tag] == CellType.O){
                   button.setTitle("O", forState: .Normal)
                } else {
                    button.setTitle(" ", forState: .Normal)
                }
                
            }
        }
    }
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = viewController
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        //print("New game button pressed.")
        gameObject.restartGame();
        
        cancelGame();
        
        flag = false;
        
        newGameButton.hidden = true;
    }
    
    // Create additional IBActions here.
    @IBAction func boardTapped(sender: UIButton) {
        if(gameObject.getCurrentGame().state() != OXGameState.InProgress && flag == true){
            let alert = UIAlertController(title: "Error", message: "Game is over. Press new game", preferredStyle:  UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .Default, handler: {(action) in
                //closure code
            })
            
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            return;
        }
        
        flag = true;
        let temp:CellType;
        if(gameObject.getCurrentGame().getMove(sender.tag) != CellType.Empty){
            let alert = UIAlertController(title: "Error", message: "Do not click on an already used square", preferredStyle:  UIAlertControllerStyle.Alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .Default, handler: {(action) in
                //Closure Code
            })
            
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        temp = gameObject.playMove(sender.tag)
        
        sender.setTitle(temp.rawValue, forState: .Normal)

        if(gameObject.getCurrentGame().state() == OXGameState.Won){
            let alert = UIAlertController(title: "Game Over", message: "Player \(temp.rawValue) Won!", preferredStyle:  UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: {(action) in
                self.newGameButton.hidden = false;
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else if (gameObject.getCurrentGame().state() == OXGameState.Tie){
            let alert = UIAlertController(title: "Game Over", message: "Tie!", preferredStyle:  UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: {(action) in
                self.newGameButton.hidden = false;
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    

}

