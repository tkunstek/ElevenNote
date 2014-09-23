//
//  Note.swift
//  ElevenNote
//
//  Copyright (c) 2014 ElevenFifty. All rights reserved.
//

import Foundation

class Note : NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = NSDate() // Defaults to current date / time
    
    // Computed property to return date as a string
    var shortDate : NSString {
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.stringFromDate(self.date)
    }
    
    override init() {
        super.init()
    }
    
    // 1: Encode ourselves...
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(text, forKey: "text")
        aCoder.encodeObject(date, forKey: "date")
    }
    
    // 2: Decode ourselves on init
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as String
        self.text  = aDecoder.decodeObjectForKey("text") as String
        self.date   = aDecoder.decodeObjectForKey("date") as NSDate
    }
    
}