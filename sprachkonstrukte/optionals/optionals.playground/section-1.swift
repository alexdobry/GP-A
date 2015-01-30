// Playground - noun: a place where people can play

import UIKit

//let nonOptional:Int = nil

// swift: userage und userInvalidAge als benutzereingaben
let userAge: String = "20"
let userInvalidAge: String = "twenty"
// toInt() kann theoretisch fehlschlagen
let convertedAge: Int? = userAge.toInt() // 20 als integer
let convertedInvalidAge: Int? = userInvalidAge.toInt() // nil

// optional auspacken und reagieren
if let convertedAge = userAge.toInt() {
    print("user is \(convertedAge) years old") /* force upwrapping of the optional value */
} else {
    print("no valid age at all") /* because of nil */
}

// optionals auf n ebenen auspacken
if let convertedAge = userAge.toInt(). {
    if let ageAdvanced = convertedAge?.advancedBy(5) {
        if let yearsLeftUntilThirty = ageAdvanced?.y
    } else { /* ... */}
} else {
    print("no valid age at all") /* because of nil */
}

// optionals direkt ansprechen
if let yearsLeftUntilThirty = userAge.toInt()?.distanceTo(30) {
    print("you have to wait \(yearsLeftUntilThirty) years") /* you have to wait 10 years */
} else {
    print("no valid age at all") /* because of nil */
}
