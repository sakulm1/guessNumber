//
//  main.swift
//  guessNumber
//
//  Created by Lukas Maile on 16.04.23.
//

import Foundation

var lowestInt = 1
var highesInt = 100

class Errors{
    
    var errorMsgs: [String] = []
    
    func getErrors() -> [String]{
        return errorMsgs
    }
    
    func add(_ item: String){
        errorMsgs.append(item)
    }
    
    func clear(){
        errorMsgs.removeAll()
    }
    
    func help() -> String{
        return """
            test:0      -> Shows number of errors
            test:1      -> Shows error messages
            test:2      -> Deletes error messages
            """
    }
    
}

class Score{
    var player: Int
    var computer: Int
    var scoreValue: Int = 1
    
    init(player: Int, computer: Int) {
        self.player = player
        self.computer = computer
    }
    
    func addPlayer(){
        player += scoreValue
    }
    
    func addComputer(_ value: Int){
        computer += value
    }
    
    func clear() -> String{
        player = 0
        computer = 0
        return "Score has been set to 0:0"
    }
    
    func get() -> String{
        return "Player: \(player) vs. Computer \(computer)"
    }
    
    func changeValue() -> String{
        var output: String = ""
        print("Please type in a number")
        if let typed = readLine() {
            if let num = Int(typed){
                scoreValue = Int(num)
                output = "Player score Value has been set to \(scoreValue)"
            }else{
                output = "❌ error"
            }

        }else{
            output = "❌ error"
        }
        if output.contains("error"){fehler.add(output)}
        return output
    }
    
    func help() -> String{
        return """
            score           -> Shows score
            score clear     -> Clears score
            score value     -> Sets the hight of the added Points of player win
            """
    }
    
}

var fehler = Errors()
var score = Score(player: 0, computer: 0)
running()

func running(){
    print("Welcome to the guess number game")
    print("Type 'help' for more Information")
    
    
    while true{
        print("->")
        let getInput = readLine()
        
        switch getInput {
        case "help":
            print(help())
        case "play":
            print(play())
        case "upperValue":
            print(changeHighest())
        case "lowerValue":
            print(changeLowest())
        case "test:0":
            print(test(0))
        case "test:1":
            print(test(1))
        case "test:2":
            print(test(2))
        case "test help":
            print(fehler.help())
        case "score help":
            print(score.help())
        case "score":
            print(score.get())
        case "score clear":
            print(score.clear())
        case "score value":
            print(score.changeValue())
        case "exit":
            print("Goodbye")
            exit(EXIT_SUCCESS)
        default:
            fehler.add("❌ error -> No command like '\(String(describing: getInput))'. Type 'help' for more Inforamtion")
            print("❌ error -> No command like '\(String(describing: getInput))'. Type 'help' for more Inforamtion")
        }
    }
}

func play() -> String{
    let randomNumber = Int.random(in: lowestInt...highesInt)
    var inGame = true
    var output: String = ""
    var guessedNumber: Int = highesInt
    while inGame == true{
        print("Guess a number: ")
        if let typed = readLine() {
            if let num = Int(typed) {
                guessedNumber = num
            }
        }
        
        if guessedNumber == randomNumber {
            output = """
            You guesst the number. 🎉
            Type 'play' to play again.
            """
            score.addPlayer()
            inGame = false
        }else if guessedNumber > randomNumber{
            print("lower ⬇️")
            score.addComputer(1)
        }else if guessedNumber < randomNumber{
            print("higher ⬆️")
            score.addComputer(1)
        }else{
            print("❌ error")
            fehler.add("❌ error")
            exit(EXIT_FAILURE)
        }
    
    }
    
    return output
}

func help() -> String{
    
    let commands = """
    ----- Here are all the commands: -----
    
    'play'          -> Runs the game
    'score'         -> Show the current Score
    'score help'    -> Show score commands
    'exit'          -> Ends the programm
    'lowerValue'    -> Changes the lowest Value
    'upperValue'    -> Changes the upper Value
    'test help'     -> explains test commands
    'test:0...2'    -> Show errors
    """
    
    return commands
}

func changeHighest() -> String{
    var output: String
    print("Highest Number is \(highesInt)")
    print("Typ the new number:")
    if let typed = readLine() {
      if let num = Int(typed){
          if num > lowestInt{
              highesInt = num
              output = "Highest Number has been changed to \(num)"
          }else{
              output = "❌ error -> number = lower then lowest number."
          }
      }else{
          output = "❌ error"
      }
    }else{
        output = "❌ error"
    }
    if output.contains("error"){fehler.add(output)}
    return output
}

func changeLowest() -> String{
    var output: String
    print("Lowest Numer is \(lowestInt)")
    print("Typ the new number:")
    if let typed = readLine() {
      if let num = Int(typed){
          if num < highesInt{
              lowestInt = num
              output = "Lowest Number has been changed to \(num)"
          }else{
              output = "❌ error -> number = higher then highest number."
          }
      }else{
          output = "❌ error"
      }
    }else{
        output = "❌ error"
    }
    if output.contains("error"){fehler.add(output)}
    return output
}


func test(_ type: Int? = nil) -> String{
   
    var msg: String = ""
    
    if type == 0 {
        msg = fehler.errorMsgs.count > 0 ? "There are \(fehler.errorMsgs.count) errors ⁉️" : "No errors ✅"
    }else if type == 1 {
        msg = "There are following errors "
        print(fehler.getErrors().count > 0 ? fehler.getErrors() : "No errors ✅")
    }else if type == 2 {
        fehler.clear()
        msg = "Cleared all errors ✅"
    }
    return msg
}


