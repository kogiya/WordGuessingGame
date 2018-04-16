//
//  Word.swift
//  WordGuessingGame
//
//  Created by Guest User on 2018-04-16.
//  Copyright © 2018 COMP3097GBC. All rights reserved.
//

import Foundation

class Word {
    var id: Int
    var word: String?
    var category: String?
    
    init(id: Int, word: String?, category: String?){
        self.id = id
        self.word = word
        self.category = category
    }
}
