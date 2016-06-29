//
//  BoardViewController.swift
//  o_X
//

import UIKit

/*class CreditCard{
    //var num;
}

class User{
    init(email_:String, password_:String?, firstName_:String, lastName_:String, middleName_:String?, creditCard_:CreditCard?){
        email = email_;
        password = password_;
        firstName = firstName_;
        middleName = middleName_;
        CreditCard = creditCard_;
    }
    
    var email:String;
    var password:String?;
    var firstName:String;
    var lastName:String;
    var middleName:String?;
    var creditCard:CreditCard?
}*/

class BoardViewController: UIViewController {

    // Create additional IBOutlets here.
   // var creditCard:CreditCard;
   // User user = ("Jbrill@gmail.com", "Hello", "Jason", "Brill", "Louis", creditCard);
    @IBOutlet weak var newGameButton: UIButton!
    var myChars = [Character](count: 9, repeatedValue: " ")
    var counter:Int = 0;
    
    //counter = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        //print("New game button pressed.")
        counter = 0;
    }
    
    // Create additional IBActions here.
    @IBAction func boardTapped(sender: UIButton) {
        if(counter%2 == 0){
            //print(sender.tag)
            myChars[Int(sender.tag)] = "X";
            sender.setAttributedTitle(NSAttributedString(string: "X"), forState: UIControlState.Normal)
        } else {
            myChars[sender.tag] = "O";
            sender.setAttributedTitle(NSAttributedString(string: "O"), forState: UIControlState.Normal)
        }
        counter += 1;
        
        //print("board tapped \(sender.tag)")
    }
    

}

