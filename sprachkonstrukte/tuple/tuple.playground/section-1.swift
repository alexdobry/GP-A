// Playground - noun: a place where people can play

import UIKit


// tuple initialisieren
var aenderbar:(Double, String) = (4.00, "Hello World")
// ansprechen
aenderbar.0
aenderbar.1

// named tuple initialisieren
let nichtAenderbar = (zahl:4.00, wort:"Hello World")
// ansprechen
nichtAenderbar.zahl
nichtAenderbar.wort

//Funktion die ein Tupel zurückgibt
func getMultipleValues() -> (name: String, isEnabled: Bool, number: Double)
{
    let _name = "Willkommen"
    let _number = 123456789.3
    let _isEnabled = true
    
    return (_name, _isEnabled,  _number)
}

var result = getMultipleValues()
//Funktionsaufruf
result.name
result.number

//Named und normaler Zugriff auf die Tupelelemente
let boolVar = result.isEnabled
let doubleVar = result.1

//Manipulation eines Tuple-Elements
//Wert in dem Tupel überschreiben
result.name = "Bye"

//Zugriff auf das erste Element
result.0
