// Playground - noun: a place where people can play

import UIKit

//call by reference
func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 5
var anotherInt = 6
swapTwoInts(&someInt, &anotherInt)

someInt
anotherInt
