// Playground - noun: a place where people can play

import UIKit

// swift struct
struct structBruch {
    var nenner = 0, zähler = 0
}

// swift klasse
class classBruch {
    var nenner = 0, zähler = 0
    
    init(nenner: Int, zähler: Int) {
        self.nenner = nenner
        self.zähler = zähler
    }
    
    init(zähler: Int) {
        self.nenner = 1
        self.zähler = zähler
    }
}

//verwendung
var a = structBruch(nenner: 3, zähler: 2)
var b = classBruch(nenner: 3, zähler: 2)
var c = classBruch(zähler: 3)

