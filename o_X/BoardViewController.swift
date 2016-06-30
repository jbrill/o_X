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
        newGameButton.hidden = true;
    }
    
    func cancelGame(){
        for subview in boardView.subviews {
            if let button = subview as? UIButton {
                button.setTitle(" ", forState: .Normal)
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

