//
//  Colors.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/24/25.
//
import UIKit

enum IncidentState: String, Codable {
    case underControl = "Under control"
    case onScene = "On Scene"
    case outOfControl = "Out of control"
    case pending = "Pending"
    
    var labelBackgroundColor: UIColor {
        switch self {
        case .underControl:
            return UIColor(red: 98.0/255.0, green: 192.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        case .onScene:
            return UIColor(red: 58.0/255.0, green: 118.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        case .outOfControl:
            return UIColor(red: 235.0/255.0, green: 79.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        case .pending:
            return .orange
        }
    }
    
}

enum SortOrder: String, Codable {
    case ascending = "ascending"
    case descending = "descending"
}
