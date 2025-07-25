//
//  Incident.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/23/25.
//

import Foundation

struct Incident: Codable {
    let title: String
    let callTime, lastUpdated: String
    let id: String
    let latitude, longitude: Double
    let description: String?
    let location, status, type: String
    let typeIcon: String
    
    var IncidentStatus: IncidentState {
        let state = IncidentState.init(rawValue: self.status) ?? .pending
        return state
    }
    //2022-07-06T12:16:59+1000
    var lastUpdatedDateString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self.lastUpdated)
        
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm:ss a"
        return dateFormatter.string(from: date ?? Date())
    }
    
    var callTimeDateString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self.callTime)
        
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm:ss a"
        return dateFormatter.string(from: date ?? Date())
    }
    
    var lastUpdatedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self.lastUpdated)
        return date ?? Date()
    }
}
