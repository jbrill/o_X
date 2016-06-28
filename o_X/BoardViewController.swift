//
//  BoardViewController.swift
//  o_X
//

import UIKit

/*class Location{
    //let location:Int;
    var currentVal:Character;
    
    init(){
        currentVal = " ";
    }
    
    func set_val(val_in:Character){
        currentVal = val_in;
    }
}*/

class BoardViewController: UIViewController {

    // Create additional IBOutlets here.
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
        
       // topLeft.titleLabel.text = "X"
    }
    
    // Create additional IBActions here.
    @IBAction func boardTapped(sender: UIButton) {
        print("board tapped \(sender.tag)")
    }
    

}

