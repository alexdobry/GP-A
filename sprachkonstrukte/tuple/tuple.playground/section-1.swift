// Playground - noun: a place where people can play

import UIKit


//Tuple initialisieren
var aenderbar:(Double, String) = (4.00, "Hello World")

//"Named Tuple" initialisieren
let nichtAenderbar = (temp1:4.00, temp2:"Hello World")

//Named tupel auslesen
nichtAenderbar.temp1
nichtAenderbar.temp2


//Funktion die ein Tupel zurückgibt
func getMultipleValues() -> (name: String, isEnabled: Bool, number: Double)
{
    let _name = "Willkommen"
    let _number = 123456789.3
    let _isEnabled = true
    
    return (_name, _isEnabled,  _number)
}

//Funktionsaufruf
var result = getMultipleValues()

//Named und normaler Zugriff auf die Tupelelemente
let boolVar = result.isEnabled
let doubleVar = result.1

//Manipulation eines Tuple-Elements
//Wert in dem Tupel überschreiben
result.name = "Bye"

//Zugriff auf das erste Element
result.0
