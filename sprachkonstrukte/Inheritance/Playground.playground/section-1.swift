// Playground - noun: a place where people can play

import UIKit


class Fortbewegungsmittel {
    
    var kmh = 0
    
    var id = 1
    
    func fahren(){
        kmh = 50
    }
}


class Flugzeug : Fortbewegungsmittel {
    
    override func fahren(){
        kmh = 70
    }
}


class Counter {
    var count = 0
    
    func increment() {
        count++
    }
    
}


let counter = Counter()

counter.increment()

let pkw = Fortbewegungsmittel()
pkw.fahren()

let airline = Flugzeug()
airline.fahren()

println(pkw.kmh)

println(airline.kmh);

println(airline.id)
