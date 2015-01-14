import UIKit

// globaler ccope für singletons
var toDoService = ToDoService()

// struct als hilfsdatenstruktur zum beschreiben eines eintrags
struct entry {
    var title:String
    var description:String
}

// die eingentliche anwendungslogik, welche das struct als hilfsstruktur verwendet
class ToDoService: NSObject {
    var entries:[entry] = []

    func addEntry(title: String, description: String) {
        entries.append(entry(title: title, description: description))
    }
}
