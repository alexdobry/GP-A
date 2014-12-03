// Playground - noun: a place where people can play

import UIKit


class Person {
    
    var name = ""
    
    init(name: String) {
        self.name = name
    }
}


class Student : Person {
    
    var uni = ""
    
    init(uni: String, name: String) {
        super.init(name: name)
        self.uni = uni
    }
    
    func exmatrikulieren(){
        self.uni = ""
    }
}


class Arbeitnehmer : Person {
    
    var arbeitgeber = ""
    
    init(arbeitgeber: String, name: String) {
        super.init(name: name)
        self.arbeitgeber = arbeitgeber
    }
    
    func kündigen(){
        self.arbeitgeber = ""
    }
}



class Werkstudent : Student, Arbeitnehmer{
    
   
}




    
    
    
    



