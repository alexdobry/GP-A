// Playground - noun: a place where people can play

import Cocoa

// Computed Properties
extension String {

    var hashtag: String{
        get{
            return "#\(self)"
        }
        set{
            let stringWithoutHashtag = newValue.stringByReplacingOccurrencesOfString("#", withString: "",
                                                                                     options: NSStringCompareOptions.LiteralSearch,
                                                                                     range: nil)
            self = stringWithoutHashtag
        }
    }
}

//Usage 
let stringOne = "GP-A"
let stringTwo = "GP-A".hashtag

var justString = String()
justString.hashtag = "#GP-A"

extension Int {
    func repetitions(task: () -> ()) { // Übergabeparameter ist eine Closure
        for i in 0..<self {
            task() // Ausführung der Closure
        }
    }
}

3.repetitions{println("Hallo")}

var state = true
1.repetitions{let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    if state == true {
        state = false
        task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "No"]
    } else {
        state = true
        task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
    }

    task.launch()
    task.waitUntilExit()

    let killTask = NSTask()
    killTask.launchPath = "/usr/bin/killall"
    killTask.arguments = ["Finder"]
    killTask.launch()
}

// patternmatching
let v: UInt = 10
switch v {
case 0...9: println("Single digit")
case 10...99: println("Double digits")
case 100...999: println("Triple digits")
default: println("4 or more digits")
}

let person = ("Helen", 25)
switch person {
case ("Helen", let age):
    println("Your name is Helen, and you are \(age)" + " years old")
case (_, 13...19):
    println("You are a teenager")
case ("Bob", _):
    println("You are not a teenager, but your name" + " is Bob.")
case (_, _):
    println("no comment")
}


let isModuloTwo = { (number) -> Bool in $0 % 2 == 0 }

// use
isModuloTwo(5)  // false
isModuloTwo(4)  // true



var stringArray = ["Hallo", "test"]
var sortedStrings = sorted(stringArray) {    $0.uppercaseString < $1.uppercaseString}




