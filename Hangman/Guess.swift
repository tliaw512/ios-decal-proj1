//
//  Guess.swift
//  Hangman
//
//  Created by Tiffany Liaw on 2/23/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class Guess {
    
    // Check if guess was correct. If correct, return true. If incorrect, return false
    func checkCorrect(word: String, guess: String) -> Bool {
        if (word.lowercased().range(of: guess.lowercased()) != nil) {
            return true
        }
        return false
    }
    
    /// Check if guess was appropriate (i.e. Only one letter) 
    func checkAppropriate(guess: String) -> Bool {
        let guessRemovedSpaces = guess.replacingOccurrences(of: " ", with: "")
        let characterSet = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if guessRemovedSpaces.characters.count == 1 {
            if guess.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    // Check if guess has already been made 
    func checkPreviousGuesses(guess: String, prevGuesses: [String]) -> Bool {
        var counter: Int = 0
        while counter < prevGuesses.count {
            if guess == prevGuesses[counter] {
                return true
            }
            counter += 1
        }
        return false
    }
}
