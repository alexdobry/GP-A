// Playground - noun: a place where people can play

import Cocoa

struct Vector2D {
    var x = 0.0, y = 0.0
}

infix operator + {}
func + (left: Vector2D, right:Vector2D) -> Vector2D {
    return Vector2D(x:left.x + right.x, y:left.y + right.y)
}

var vec1 = Vector2D(x: 0.5, y: 0.1)
var vec2 = Vector2D(x: 0.9, y: 0.4)

var vec3 = vec1 + vec2


prefix operator +++ {}
prefix func +++ (i:Int) -> Int {
    return i + 2
}
var i1 = 0

i1 = +++i1


postfix operator +++ {}
postfix func +++ (i:Int) -> Int {
    return i + 2
}

i1 = i1+++
