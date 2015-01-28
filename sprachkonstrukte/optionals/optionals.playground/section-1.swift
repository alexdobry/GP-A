// Playground - noun: a place where people can play

import UIKit

//let nonOptional:Int = nil

let userAge: String = "20"
let userInvalidAge: String = "twenty"
//let convertedAge: Int? = userAge.toInt() /* 20 as a integer */
let convertedInvalidAge: Int? = userInvalidAge.toInt() /* nil, no valid integer */

if let convertedAge = userAge.toInt() {
    print("user is \(convertedAge) years old") /* force upwrapping of the optional value */
} else {
    print("no valid age at all") /* because of nil */
}

if let convertedAge = userAge.toInt() {
    if let yearsLeftUntilThirty = convertedAge.distanceTo(30) {
        print("you have to wait \(yearsLeftUntilThirty) years") /* you have to wait 10 years */
    } else { /* ... */}
} else {
    print("no valid age at all") /* because of nil */
}

if let yearsLeftUntilThirty = userAge.toInt()?.distanceTo(30) {
    print("you have to wait \(yearsLeftUntilThirty) years") /* you have to wait 10 years */
} else {
    print("no valid age at all") /* because of nil */
}