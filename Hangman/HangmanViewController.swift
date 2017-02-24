//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    // Word to Guess
    var wordToGuessVar: String = ""
    
    /* Incorrect guesses counter
        * If reaches 6, then game is over */
    var incorrectGuessCount: Int = 0
    
    // Previous guesses
    var prevGuesses: [String] = []
    var numGuesses: Int = 0
    
    // Guess model to perform functions of pressing guess button
    let guessWork = Guess()
    
    // Label for word to guess
    @IBOutlet weak var wordToGuess: UILabel!
    
    // Label for incorrect guesses
    @IBOutlet weak var incorrectGuesses: UILabel!
    
    // Textfield for inputting guess
    @IBOutlet weak var guess: UITextField!
    
    // UIImageView for hangman image
    @IBOutlet weak var hangmanImage: UIImageView!
    
    // Guess button for updating game state
    @IBAction func guessButton(_ sender: Any) {
        
        // If guess was not appropriate, give alert telling player to guess again
        if !guessWork.checkAppropriate(guess: self.guess.text!) {
            let alertController = UIAlertController(title: "Sorry", message: "Guess must be one letter and within the alphabet", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true)
        }
            
        // If guess has already been made, give alert telling player to guess again
        else if guessWork.checkPreviousGuesses(guess: guess.text!, prevGuesses: prevGuesses) {
            let alertController = UIAlertController(title: "Sorry", message: "You have already guessed this letter", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true)
        }
            
        else {
        // If correct, update wordToGuess by replacing "-" with guess
            if guessWork.checkCorrect(word: wordToGuessVar, guess: self.guess.text!) {
                let charPhrase = Array(wordToGuessVar.characters) // Array of actual word
                let charCurrent = Array(wordToGuess.text!.characters) // Array of "-" and letters
                var newWord = "" // Word to replace current words to guess
                
                var i = 0
                while i < charPhrase.count {
                    if String(charPhrase[i]).lowercased().range(of: guess.text!.lowercased()) != nil {
                        newWord += guess.text!
                     } else {
                        newWord += String(charCurrent[i])
                     }
                    i += 1
                }
                wordToGuess.text = newWord.lowercased()
            
                // Check if player has won game
                if wordToGuess.text?.range(of: "-") == nil {
                    let alertController = UIAlertController(title: "Congratulations, you won!", message: "Press the button below to start a new game.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: startNewGame))
                    self.present(alertController, animated: true)
                }
            }
            
                // If incorrect, update ImageView and incorrect Guesses
            else {
                incorrectGuessCount += 1
                // Update incorrectGuesses label text to show incorrect guesses
                incorrectGuesses.text! += guess.text! + ", "
            
            
                // Update image to represent game state
                if incorrectGuessCount == 1 {
                    hangmanImage.image = #imageLiteral(resourceName: "hangman2")
                } else if incorrectGuessCount == 2 {
                    hangmanImage.image = #imageLiteral(resourceName: "hangman3")
                } else if incorrectGuessCount == 3 {
                    hangmanImage.image = #imageLiteral(resourceName: "hangman4")
                } else if incorrectGuessCount == 4 {
                    hangmanImage.image = #imageLiteral(resourceName: "hangman5")
                } else if incorrectGuessCount == 5 {
                    hangmanImage.image = #imageLiteral(resourceName: "hangman6")
                } else {
                    hangmanImage.image = #imageLiteral(resourceName: "hangman7")
                }
            
                // Player has lost game
                if incorrectGuessCount == 6 {
                    let alertController = UIAlertController(title: "What a loser, you have died", message: "Press the button below to start a new game.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default, handler: startNewGame))
                    self.present(alertController, animated: true)
                }
            }
            prevGuesses.append(guess.text!)
            numGuesses += 1
        }
        guess.text = ""

    }
    
    func startNewGame(action: UIAlertAction) {
        self.viewDidLoad()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "chalkboard"))
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
        wordToGuessVar = phrase
        let charPhrase = Array(phrase.characters)
        prevGuesses = []
        incorrectGuessCount = 0;
        numGuesses = 0;
        
        // Initate Guessed Word label
        var word : String = "";
        var i: Int = 0
        while i < phrase.characters.count {
            if charPhrase[i] == " " {
                word += " "
            } else {
                word += "-"
            }
            i += 1
        }
        wordToGuess.text = word
        wordToGuess.textColor = UIColor.white
        
        // Initiate Incorrect Guesses Label
        incorrectGuesses.text = String("Incorrect Guesses: ")
        incorrectGuesses.textColor = UIColor.white
        
        // Initiate Guess Textfield
        guess.text = ""
        
        // Initiate hangman image
        hangmanImage.image = #imageLiteral(resourceName: "hangman1")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
