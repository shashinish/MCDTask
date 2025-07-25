//
//  Constants.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/23/25.
//

import Foundation

enum Constants {
    static var baseUrl = "https://mocki.io/v1/"
    
}

enum Endpoints: String {
    case incidents = "f94dc847-768c-419e-8940-2967a1e573a6"
    
    func getPath() -> String{
        switch self {
        case .incidents:
            return "\(Constants.baseUrl)\(self.rawValue)"
        }
    }
}
