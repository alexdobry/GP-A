// Playground - noun: a place where people can play

import Cocoa
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]

let emptyArray = [String](shoppingList)
//let emptyDictionary = [String: String](occupations)

// Swift array literal
var array = ["Entry1", "Entry2"]
// Swift dictionary literal
var dict = [
    1: "Entry1",
    2: "Entry2",
]
// Swift closure literal
let sortedStrings = sorted(array) {
    $0.uppercaseString < $1.uppercaseString
}

// swift: konkatenation von variablen
var age = 18
var concat = "age: \(age)" // age: 18



