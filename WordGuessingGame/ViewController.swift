//
//  ViewController.swift
//  WordGuessingGame
//
//  Created by Guest User on 2018-03-19.
//  Copyright © 2018 COMP3097GBC. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    var db: DbManager?
    var wordList = [Word]()
    var word:Word!;
    var lettersFound = 0;
    var guessCurIndex = 0;
    
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    //Letters in the word
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var l6: UILabel!
    @IBOutlet weak var l7: UILabel!
    @IBOutlet weak var l8: UILabel!
    
    //Underscores
    @IBOutlet weak var u1: UILabel!
    @IBOutlet weak var u2: UILabel!
    @IBOutlet weak var u3: UILabel!
    @IBOutlet weak var u4: UILabel!
    @IBOutlet weak var u5: UILabel!
    @IBOutlet weak var u6: UILabel!
    @IBOutlet weak var u7: UILabel!
    @IBOutlet weak var u8: UILabel!
    
    var lblLettersArr:[UILabel]!
    var lblUnderscoresArr:[UILabel]!
    
    //Letters (buttons)
    @IBAction func btnA(_ sender: UIButton) {
        checkGuess(button: sender)
        sender.isEnabled = false;
        sender.setTitleColor(UIColor.clear, for: .disabled)
    }
    @IBAction func btnB(_ sender: UIButton) {
    }
    @IBAction func btnC(_ sender: UIButton) {
    }
    @IBAction func btnD(_ sender: UIButton) {
    }
    @IBAction func btnE(_ sender: UIButton) {
    }
    @IBAction func btnF(_ sender: UIButton) {
    }
    @IBAction func btnG(_ sender: UIButton) {
    }
    @IBAction func btnH(_ sender: UIButton) {
    }
    @IBAction func btnI(_ sender: UIButton) {
    }
    @IBAction func btnJ(_ sender: UIButton) {
    }
    @IBAction func btnK(_ sender: UIButton) {
    }
    @IBAction func btnL(_ sender: UIButton) {
    }
    @IBAction func btnM(_ sender: UIButton) {
    }
    @IBAction func btnN(_ sender: UIButton) {
    }
    @IBAction func btnO(_ sender: UIButton) {
    }
    @IBAction func btnP(_ sender: UIButton) {
    }
    @IBAction func btnQ(_ sender: UIButton) {
    }
    @IBAction func btnR(_ sender: UIButton) {
    }
    @IBAction func btnS(_ sender: UIButton) {
    }
    @IBAction func btnT(_ sender: UIButton) {
    }
    @IBAction func btnU(_ sender: UIButton) {
    }
    @IBAction func btnV(_ sender: UIButton) {
    }
    @IBAction func btnW(_ sender: UIButton) {
    }
    @IBAction func btnX(_ sender: UIButton) {
    }
    @IBAction func btnY(_ sender: UIButton) {
    }
    @IBAction func btnZ(_ sender: UIButton) {
    }

    //Balloons
    @IBOutlet weak var balloon1: UIImageView!
    @IBOutlet weak var balloon2: UIImageView!
    @IBOutlet weak var balloon3: UIImageView!
    @IBOutlet weak var balloon4: UIImageView!
    @IBOutlet weak var balloon5: UIImageView!
    @IBOutlet weak var balloon6: UIImageView!
    
    var imgBalloonsArr:[UIImageView]!
    
    //Bees
    @IBOutlet weak var bee1: UIImageView!
    @IBOutlet weak var bee2: UIImageView!
    @IBOutlet weak var bee3: UIImageView!
    @IBOutlet weak var bee4: UIImageView!
    @IBOutlet weak var bee5: UIImageView!
    @IBOutlet weak var bee6: UIImageView!
    
    var imgBeesArr:[UIImageView]!
    
    
    @IBAction func backToStart(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func showInstructions(_ sender: UIButton) {
        //Alert title and content
        let alertController = UIAlertController(title: "Instructions", message: "Try to guess the secret word one letter at a time! If you guess an incorrect letter, the bee will pop one balloon. To win, spell the word before the bee pops all balloons!", preferredStyle: UIAlertControllerStyle.alert)
        
        //Buttons
        alertController.addAction(UIAlertAction(title: "Back to the game", style: UIAlertActionStyle.default, handler: nil))
        
        //Show alert
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        db = DbManager();
        
        //create arrays with the references to the labels and images
        lblLettersArr = [l1, l2, l3, l4, l5, l6, l7, l8]
        lblUnderscoresArr = [u1, u2, u3, u4, u5, u6, u7, u8]
        imgBeesArr = [bee1, bee2, bee3, bee4, bee5, bee6]
        imgBalloonsArr = [balloon1, balloon2, balloon3, balloon4, balloon5, balloon6]
        
        //Select a random word
        word = (db?.selectRandom())!
        
        //print hint to the category label
        lblCategory.text = word?.category
        
        //Print underscores
        var numOfCharacters = word.word.count
        print(word?.word)
        for i in 0 ..< numOfCharacters {
            lblUnderscoresArr[i].isHidden = false;
            let myWord = Array(word.word.characters)
            lblLettersArr[i].text = String(myWord[i]).uppercased()
        }
        
        //Hide all letters in the word
        for i in 0 ..< lblLettersArr.count {
            lblLettersArr[i].isHidden = true;
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func StartGame(_ sender: Any) {
        print("Start button is pressed")
    }
    @IBAction func ShowAbout(_ sender: Any) {
        print("Avout button is pressed")
    }
    
    //Check if selected letter is in the word
    func isInWord(letter:UIButton) -> Bool{
        var valid = false;
        var indexes = indexOf(word: word.word!, ch: Character(letter.title(for: .normal)!))
        
        for i in 0..<indexes.count {
            lblLettersArr[indexes[i]].isHidden = false
            valid = true
            //Add to the number of letters found
            lettersFound = lettersFound + 1
        }
        
        return valid
    }
    
    //Check if game is over
    func checkGuess(button:UIButton){
        if isInWord(letter: button){
            if lettersFound == word.word.count{
                print("User won")
            }
        } else {
            //pop a balloon
            imgBalloonsArr[guessCurIndex].isHidden = true;
            //move a bee
            imgBeesArr[guessCurIndex].isHidden = true;
            
            //increment guess current index
            guessCurIndex = guessCurIndex + 1
            
            if guessCurIndex == 6 {
                print("game over")
            }
            else {
                imgBeesArr[guessCurIndex].isHidden = false;
            }
        }
    }
    
    func indexOf(word:String, ch:Character)->[Int]{
        var indexes:[Int] = []
        
        var wordArr = Array(word.uppercased().characters)
        for i in 0 ..< word.count {
            if ch == wordArr[i] {
                indexes.append(i)
            }
        }
        
        print(indexes)
        return indexes
    }
    
}

