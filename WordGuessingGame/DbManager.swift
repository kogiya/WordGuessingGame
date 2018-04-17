//
//  DbManager.swift
//  WordGuessingGame
//
//  Created by Aline N Alencar on 2018-04-17.
//  Copyright © 2018 COMP3097GBC. All rights reserved.
//

import Foundation

import SQLite3

class DbManager {
    var db: OpaquePointer?
    init() {
        //create and open the db

        //creating database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("WordBankDatabase.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE WordBank (id INTEGER PRIMARY KEY AUTOINCREMENT, word TEXT, category TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        } else {
            //If the table is being created, then insert the words to it
            //creating a statement
            var stmt: OpaquePointer?
            
            //insert query
            let queryString = "INSERT INTO WordBank (word, category)VALUES('apple', 'fruit'),('orange', 'fruit'), ('banana', 'fruit'), ('dog', 'animal'), ('cat', 'animal'), ('elephant', 'animal'), ('red', 'color'), ('green', 'color'), ('pink', 'color'), ('tennis', 'sport'), ('soccer', 'sport'), ('baseball', 'sport')"
            
            print(queryString)
            
            //preparing the query
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
                return
            }
            
            //execute the query to insert values
            if sqlite3_step(stmt) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure inserting word: \(errmsg)")
                return
            }
        }
       
        
    }
    
    deinit {
        //deconstructor
        //destroy the object
        //close the db
    }
    
    //Select a random row from the database
    func selectRandom()-> Word{
        var word:Word!
        
        //select query
        let queryString = "SELECT * FROM WordBank ORDER BY RANDOM() LIMIT 1;"
        
        //statement pointer
        var stmt: OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        } else {
            //traversing through all the records
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = sqlite3_column_int(stmt, 0)
                let wordKey = String(cString: sqlite3_column_text(stmt, 1))
                let category = String(cString: sqlite3_column_text(stmt, 2))
                
                word = Word(id: Int(id), word: String(wordKey), category: String(category))
            }
        }

        return word
    }
}
