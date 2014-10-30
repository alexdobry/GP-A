// Playground - noun: a place where people can play

import Cocoa



// Fibonacci
func fibonacci(n: Int) -> Int {
    if (n == 0 || n == 1) {
        return n
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
}

var testFib = fibonacci(4)