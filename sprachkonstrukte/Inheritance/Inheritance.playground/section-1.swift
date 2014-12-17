// Playground - noun: a place where people can play

import Cocoa

class Tier {
    var anzahlBeine = 0
    var taetigkeit = ""
    
    init(anzahlBeine: Int) {
        self.anzahlBeine = anzahlBeine
    }
    
    func laufen(){
        taetigkeit = "laufen"
    }
}


class Ente : Tier {
    
    init(){
        super.init(anzahlBeine: 2)
    }
    
    override func laufen(){
        taetigkeit = "langsames watscheln"
    }
    
    func fliegen(){
        taetigkeit = "fliegen"
    }
}


class Katze : Tier, Speaker {
    init(){
        super.init(anzahlBeine: 4)
    }
    
    func mausjagen(){
        taetigkeit = "maus jagen"
    }
    
    func speak(){
        taetigkeit = "sprechen"
    }
}


protocol Speaker {
    func speak()
}


class Person : Speaker {
    func speak(){
        println("hallo")
    }
}


var tier = Tier(anzahlBeine : 4)
tier.laufen()

var ente = Ente()
ente.fliegen()
ente.laufen()

var katze = Katze()
katze.mausjagen()
katze.laufen()
katze.speak()

var person = Person()
person.speak()

