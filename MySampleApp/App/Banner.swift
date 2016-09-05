//
//  Banner.swift
//  Connekt
//
//  Created by Jae Hyun Kim on 8/31/16.
//
//

import Foundation

class Banner {
    
    var text: String
    var location: Location
    var time: Time
    var date: Date

    init(text: String, location: Location, time: Time, date: Date) {
        self.text = text
        self.location = location
        self.time = time
        self.date = date
    }
    
    
}