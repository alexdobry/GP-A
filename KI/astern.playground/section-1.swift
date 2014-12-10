/*

Funktionsausführung mit Erklärung am Ende der Datei.

Ausgabe auf Konsole.
Konsole in xCode anzeigen lassen:
View -> Assistant Editor -> Show Assistent Editor


*/



import Foundation
import Cocoa

class Vertex {
    var key: String
    var neighbours: Array<Edge>
    var wegkosten: Int?
    var successor: Vertex?
    
    init(nameParam: String) {
        self.key = nameParam
        self.neighbours = Array<Edge>()
    }
    
    func addEdge(weg: Edge) {
        self.neighbours.append(weg)
    }
    
    func nachbarn() -> [Edge] {
        return self.neighbours
    }
    
    func setWegkosten(kosten: Int) {
        self.wegkosten = kosten
    }
    
    func setSuccessor(node: Vertex) {
        self.successor = node
    }
    
    func getWegkosten() -> Int? {
        return wegkosten
    }
    
    func getKey() -> String {
        return key
    }
}

func == (v1: Vertex, v2: Vertex) -> Bool {
    return v1.key == v2.key
}

class Edge {
    var source: Vertex
    var destination: Vertex
    var distances: Int
    var marker = false
    
    init(sourceParam: Vertex, destinationParam: Vertex, distancesParam: Int) {
        self.source = sourceParam
        self.destination = destinationParam
        self.distances = distancesParam
    }
    
    func start() -> Vertex {
        return self.source
    }
    
    func ende() -> Vertex {
        return self.destination
    }
    
    func gewicht() -> Int {
        return self.distances
    }
    
    func mark() {
        self.marker = true
    }
}

// Vertexes initialisieren
var sb = Vertex(nameParam: "Saarbrücken")
var kl = Vertex(nameParam: "Kaiserslautern")
var ffm = Vertex(nameParam: "Frankfurt")
var lh = Vertex(nameParam: "Ludwigshafen")
var wb = Vertex(nameParam: "Würzburg")
var kr = Vertex(nameParam: "Karlsruhe")
var hb = Vertex(nameParam: "Heilbronn")

// Edges initialisieren
var strasse1 = Edge(sourceParam: sb, destinationParam: kl, distancesParam: 70)
sb.addEdge(strasse1)
kl.addEdge(strasse1)
var strasse2 = Edge(sourceParam: kl, destinationParam: ffm, distancesParam: 103)
kl.addEdge(strasse2)
ffm.addEdge(strasse2)
var strasse3 = Edge(sourceParam: kl, destinationParam: lh, distancesParam: 53)
kl.addEdge(strasse3)
lh.addEdge(strasse3)
var strasse4 = Edge(sourceParam: lh, destinationParam: wb, distancesParam: 183)
lh.addEdge(strasse4)
wb.addEdge(strasse4)
var strasse5 = Edge(sourceParam: ffm, destinationParam: wb, distancesParam: 116)
ffm.addEdge(strasse5)
wb.addEdge(strasse5)
var strasse6 = Edge(sourceParam: wb, destinationParam: hb, distancesParam: 102)
wb.addEdge(strasse6)
hb.addEdge(strasse6)
var strasse7 = Edge(sourceParam: hb, destinationParam: kr, distancesParam: 84)
hb.addEdge(strasse7)
kr.addEdge(strasse7)
var strasse8 = Edge(sourceParam: sb, destinationParam: kr, distancesParam: 145)
sb.addEdge(strasse8)
kr.addEdge(strasse8)




//A Stern

var openList = [(Int, Vertex)]()
var closedList = [Vertex]()

func astar(start: Vertex, ziel: Vertex) {
    // OpenList mit Startknoten initialisieren
    openList.append((0, start))
    start.setWegkosten(0)
    
    //Algorhitmus durchführen bis die openList leer ist.
    while openList.isEmpty == false {
        var arrayindx = 0
        for (index, element) in enumerate(openList) {
            if(element.0 < openList[arrayindx].0) {
                arrayindx = index
            }
        }
        
        var currentNode: Vertex = openList[arrayindx].1
        openList.removeAtIndex(arrayindx)
        if(currentNode == ziel) {
            closedList.append(currentNode)
            let last = closedList.removeLast()
            println("Nach \(last.getKey()) sind es \(last.getWegkosten()!)km.")
            println("Der Weg führt über:")
            var zielpfad = [String]()
            zielpfad.append(last.getKey())
            var pathcomplete = false
            var tmp = last
            while(pathcomplete != true) {
                tmp = tmp.successor!
                zielpfad.append(tmp.getKey())
                if(tmp.successor == nil) {
                    pathcomplete = true
                }
            }
            println("\(zielpfad.reverse())")
            break
        }
        closedList.append(currentNode)
        expandNode(currentNode)
    }
}

func expandNode(node: Vertex) {
    for strasse in node.nachbarn() {
        var tmpnode: Vertex
        if(strasse.destination == node) {
            tmpnode = strasse.source
        }
        else {
            tmpnode = strasse.destination
        }
        
        var closedListContainsSuccessor = false
        for element in enumerate(closedList) {
            if(tmpnode == element.1) {
                closedListContainsSuccessor = true
            }
        }
        if(closedListContainsSuccessor == true) {
            continue
        }
        
        var g = strasse.gewicht() + node.wegkosten!

        var alterWertKleiner = false
        for (index, element) in enumerate(openList) {
            if(element.1 == tmpnode) {
                if(tmpnode.getWegkosten() <= g) {
                    alterWertKleiner = true
                }
            }
        }
        
        if(alterWertKleiner == true) {
            continue
        }
        
        
        tmpnode.setWegkosten(g)
        tmpnode.setSuccessor(node)
        
        if(openList.isEmpty == true) {
            openList.append((g, tmpnode))
        }
        else {
            var inOpenList = false
            for (index, element) in enumerate(openList) {
                if(element.1 == tmpnode) {
                    openList[index].0 = g
                    inOpenList = true
                }
            }
            if(inOpenList == false) {
                openList.append((g, tmpnode))
            }
            
        }
    }
}


/*

Der Graph in Ascii (sogut es geht...)
Grafik: http://upload.wikimedia.org/wikipedia/commons/6/62/Astar-germany0.svg

func astern(Startort: Vertex, Zielort: Vertex)

             +---+
 +--103------+ffm+-------116-+
 |           +---+           |
 |                           |
+--+         +--+           +-++
|kl+---53----+lh+----183----+wb|
+-++         +--+           +-++
 |                           |
70                          102
 |                           |
++-+         +--+          +-++
|sb+---145---+kr+---84-----+hb|
+--+         +--+          +--+

*/

astar(sb, wb)
