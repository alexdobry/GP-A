// Playground - noun: a place where people can play

import UIKit

//Tuple initialisieren
var tipAndTotal:(Double, String) = (4.00, "randomText")


//Zugriff auf das erste Element und in einer neuen Variable speichern
var element1 = tipAndTotal.0


//Manipulation eines Tuple-Elements
tipAndTotal.1 = "newText"


//"Named Tuple" initialisieren und Auslesen
let tipAndTotalNamed = (tipAmt:4.00, total:25.19)

tipAndTotalNamed.tipAmt
tipAndTotalNamed.total
