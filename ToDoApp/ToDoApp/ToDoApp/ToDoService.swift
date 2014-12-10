import UIKit

// Global Scope für Singletons
var toDoService = ToDoService()

// struct als hilfsdatenstruktur zum beschreiben eines eintrags
struct entry {
    var title:String
    var description:String
}

class ToDoService: NSObject {
    var entries:[entry] = []
    
    func addEntry(title: String, description: String) {
        entries.append(entry(title: title, description: description))
    }
}
