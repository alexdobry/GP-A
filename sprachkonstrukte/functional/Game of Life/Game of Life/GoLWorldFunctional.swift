//
//  GoLWorldFunctional.swift
//  Game of Life
//
//  Created by pascal on 15.12.14.
//  Copyright (c) 2014 pixelskull. All rights reserved.
//

import Foundation
import Dollar

class GoLWorldFunctional {
    var aliveCells:Array<Point> = []

    func addCell(var point: Point) { self.aliveCells.append(point) }

    func tick() {
        let cellsWithNeighbours = countCellsWithNeighbours(self.aliveCells)
        // rules for livingCells
        let livingCells: Array<Point> = self.aliveCells.filter{
            (cell:Point) -> Bool in
            let count: Int? = cellsWithNeighbours[cell]
            return count == 2 || count == 3 ? true : false
        }
        //rules for creating new live
        let newLife = cellsWithNeighbours.filter{
            (_, count: Int) -> Bool in
            return count == 3 ? true : false
        }
        self.aliveCells = $.merge(arrays: livingCells, newLife.keys.array)
    }

    func countCellsWithNeighbours(cells: Array<Point>) -> Dictionary<Point, Int> {
        return self.countCellsWithNeighbours(cells, countHash: Dictionary<Point, Int>())
    }

    func countCellsWithNeighbours(cells:Array<Point>, var countHash:Dictionary<Point,Int>) -> Dictionary<Point, Int> {
        if (cells.count == 0){
            return countHash
        } else {
            if countHash.count == 0 { countHash = initEmptyCounterHash() }
            let tmpCount = self.countNeighbours(cells.first!.neighbours(), countHash: countHash)
            return countCellsWithNeighbours(cells.dropFirst(), countHash: tmpCount)
        }
    }

    func countNeighbours(neighbours:Array<Point>, var countHash:Dictionary<Point,Int>) -> Dictionary <Point, Int> {
        if neighbours.count == 0 {
            return countHash
        } else {
            let first = neighbours.first!
            if let currentCounter = countHash[first] {
                countHash[first] = currentCounter + 1
            } else {
                countHash[first] = 1
            }
            return countNeighbours(neighbours.dropFirst(), countHash: countHash)
        }
    }

    func initEmptyCounterHash() -> Dictionary<Point, Int> {
        return self.initEmptyCounterHash(self.aliveCells, counterHash: Dictionary<Point, Int>())
    }

    func initEmptyCounterHash(cells: Array<Point>, var counterHash: Dictionary<Point, Int>) -> Dictionary<Point, Int> {
        if cells.count == 0 {
            return counterHash
        } else {
            counterHash[cells.first!] = 0
            return self.initEmptyCounterHash(cells.dropFirst(), counterHash: counterHash)
        }
    }
}

extension Dictionary {
    /// Return an `Dictionary` containing the elements `x` of `self` for which
    /// `includeElement(x)` is `true`
    func filter(includeElement: (Key, Value) -> Bool) -> [Key: Value] {
        var ret = [Key:Value]()
        for (key:Key, value:Value) in self {
            if includeElement(key, value) {
                ret[key] = value
            }
        }
        return ret
    }
}

extension Array {
    /// dropFirst element and returns the rest as an Array (not like dropfirst(seq) a sequence)
    func dropFirst() -> [T] {
        var tmp:[T] = []
        if self.count > 0 {
            for(var i = 1; i < self.count; i++){
                tmp.append(self[i])
            }
        }
        return tmp
    }
}
