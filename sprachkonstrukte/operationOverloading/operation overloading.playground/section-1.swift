// Playground - noun: a place where people can play

import Cocoa

var stringVar = "Hello"
var integerVar = 5

var concat = stringVar + String(integerVar)
var concatDifferent = "Hello \(integerVar)"

// zugrundeliegende datenstruktur
struct Bruch {
    var nenner = 0, zähler = 0
}

// inflix binär
func * (multiplikator: Bruch, multiplikant: Bruch) -> Bruch {
    return Bruch(nenner: multiplikator.nenner * multiplikant.nenner, zähler: multiplikator.zähler * multiplikant.zähler)
}

// prefix unär
prefix operator *** {}

prefix func *** (inout bruch: Bruch) -> Bruch {
    bruch = bruch * bruch
    return bruch
}

// verwendung
var a = Bruch(nenner: 3, zähler: 2)
var b = Bruch(nenner: 5, zähler: 3)
var produkt = a * b

var verdoppelt = ***produkt
