// Playground - noun: a place where people can play

import Cocoa

// Computed Properties
extension String {

    var hashtag: String{
        get{
            return "#\(self)"
        }
        set{
            let stringWithoutHashtag = newValue.stringByReplacingOccurrencesOfString("#", withString: "",
                                                                                     options: NSStringCompareOptions.LiteralSearch,
                                                                                     range: nil)
            self = stringWithoutHashtag
        }
    }
}

//Usage 
let stringOne = "GP-A"
let stringTwo = "GP-A".hashtag

var justString = String()
justString.hashtag = "#GP-A"
