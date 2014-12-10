// Playground - noun: a place where people can play
// src: Raywenderlich.com (swift-functional-programming-tutorial)
import UIKit

//Simple Array Filtering 
// imperative way
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
println(evens)
evens = []

// functional way
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
evens = Array(1...10).filter(isEven)
evens = []

// functional way with closures
evens = Array(1...10).filter { (number) in number % 2 == 0 }
println(evens)
evens = []

// concise as possible
evens = Array(1...10).filter{ $0 % 2 == 0 } // $0 is argument shorthand notation
println(evens)
evens = []


// reimplementing .filter
// imperative way
func myFilter<T>(source: [T], predicate: (T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}
evens = myFilter(Array(1...10)) { $0 % 2 == 0 }
println(evens)
evens = []

// classextension
extension Array {
    func myFilter(predicate: (T) -> Bool) -> [T] {
        var result = [T]()
        for i in self {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
}
evens = Array(1...10).myFilter{ (number) in number % 2 == 0 }
println(evens)


// manual reducing (imperative)
evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
var evenSum = 0
for i in evens {
    evenSum += i
}

println(evenSum)

// reducing (functional)
evenSum = Array(1...10)
    .filter { $0 % 2 == 0 }
    .reduce(0) { (total, number) in total + number }
println(evenSum)

// find max. number
let maxNumber = Array(1...10)
    .reduce(0) { (total, number) in max(total, number) }

// list all numbers 
let numbers = Array(1...10)
    .reduce("numbers: ") { (total, number) in total + "\(number) " }


// reimplementing reduce 
extension Array {
    func myReduce<T, U>(seed: U, combiner:(U,T) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(current, item as T)
        }
        return current
    }
}

// array to int
let digits = ["3", "1", "4", "1"]
let digit = digits
    .myReduce("") { $0 + $1 }.toInt()!


// Building an Index
//import Foundation

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "monkey"]

typealias Entry = (Character, [String])

func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()
    for item in source {
        if !contains(unique, item) {
            unique.append(item)
        }
    }
    return unique
}

func buildIndex(words: [String]) -> [Entry] {
    func firstLetter(str: String) -> Character {
        return Character(str.substringToIndex(
            advance(str.startIndex, 1)).uppercaseString)
    }

    let letters = words.map{
        (word) -> Character in
        firstLetter(word)
    }
    return distinct(letters).map {
        (letter) -> Entry in
        return (letter, words.filter {
            (word) -> Bool in
            firstLetter(word) == letter
        })
    }
}
println(buildIndex(words))


// imperative way
//func buildIndex(words: [String]) -> [Entry] {
//    var result = [Entry]()
//
//    var letters = [Character]()
//    for word in words {
//        let firstLetter = Character(word.substringToIndex(
//            advance(word.startIndex, 1)).uppercaseString)
//
//        if !contains(letters, firstLetter) {
//            letters.append(firstLetter)
//        }
//    }
//
//    for letter in letters {
//        var wordsForLetter = [String]()
//        for word in words {
//            let firstLetter = Character(word.substringToIndex(
//                advance(word.startIndex, 1)).uppercaseString)
//
//            if firstLetter == letter {
//                wordsForLetter.append(word)
//            }
//        }
//        result.append((letter, wordsForLetter))
//    }
//    return result
//}
//println(buildIndex(words))





