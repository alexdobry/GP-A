//
//  Point.swift
//  Game of Life
//
//  Created by pascal on 11.12.14.
//  Copyright (c) 2014 pixelskull. All rights reserved.
//

import Foundation

struct Point : Hashable, Equatable {

    var x:Int, y:Int = 0

    init(x:Int, y:Int) {
        self.x = x
        self.y = y
    }

    var hashValue: Int {
        return x * 10000 + y
    }

    func neighbours() -> Array<Point> {
        var result:Array<Point> = []
        for xModifier in (-1...1) {
            for yModifier in (-1...1) {
                if xModifier != 0 || yModifier != 0 {
                    result.append(Point(x: self.x + xModifier, y: y + yModifier))
                }
            }
        }
        return result
    }

    func toString(point:Point) -> String {
        return "x: \(point.x) | y: \(point.y) | hash: \(point.hashValue)"
    }
}

func ==(lhs: Point, rhs:Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
