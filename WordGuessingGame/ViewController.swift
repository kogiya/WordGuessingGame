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
    var word:Word?;

    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    //Letters
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
        
        //create references to the labels
        lblLettersArr = [l1, l2, l3, l4, l5, l6, l7, l8]
        lblUnderscoresArr = [u1, u2, u3, u4, u5, u6, u7, u8]
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        //createing database file
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            .appendingPathComponent("WordBankDatabase.sqlite")
//
//        //opening the database
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//            print("error opening database")
//        }
//
//        //creating table
//        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS WordBank (id INTEGER PRIMARY KEY AUTOINCREMENT, word TEXT, category TEXT)", nil, nil, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error creating table: \(errmsg)")
//        }
//
//        //creating a statement
//        var stmt: OpaquePointer?
//
//        //insert query
//        let queryString = "INSERT INTO WordBank (word, category)VALUES('apple', 'fruit'),('orange', 'fruit'), ('banana', 'fruit'), ('dog', 'animal'), ('cat', 'animal'), ('elephant', 'animal'), ('red', 'color'), ('green', 'color'), ('pink', 'color'), ('tennis', 'sport'), ('soccer', 'sport'), ('baseball', 'sport')"
//
//        print(queryString)
//
//        //preparing the query
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errmsg)")
//            return
//        }
//
//        //execute the query to insert values
//        if sqlite3_step(stmt) != SQLITE_DONE {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("failure inserting word: \(errmsg)")
//            return
//        }
        
//        readValues()
//
//        let countWordBankRow = wordList.count
//        let randomId = arc4random_uniform(UInt32(countWordBankRow))
//        let selectedWord = wordList[Int(randomId)]

        //********************** cannot display category 
//        lblCategory.text = selectedWord.category
        
        
        //Select a random word
        var word:Word = (db?.selectRandom())!
        
        //print hint to the category label
        lblCategory.text = word.category
        
        //Print underscores
        var numOfCharacters = word.word.count
        print(word.word)
//        lblWord.text = ""
//        for i in 0 ..< numOfCharacters {
//            lblWord.text = lblWord.text! + " _ "
//        }
        
        
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
    
//    func readValues(){
//        //empty the list of words
//        wordList.removeAll()
//
//        //select query
//        let queryString = "SELECT * FROM WordBank"
//
//        //statement pointer
//        var stmt: OpaquePointer?
//
//        //preparing the query
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errmsg)")
//            return
//        }
//
//        //traversing through all the records
//        while(sqlite3_step(stmt) == SQLITE_ROW){
//            let id = sqlite3_column_int(stmt, 0)
//            let word = String(cString: sqlite3_column_text(stmt, 1))
//            let category = String(cString: sqlite3_column_text(stmt, 2))
//
//            //adding values to list
//            wordList.append(Word(id: Int(id), word: String(word), category: String(category)))
//        }
//    }
    
    
}

