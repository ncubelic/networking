//
//  URL+NetworkManager.swift
//  Networking
//
//  Created by Nikola on 17.8.2019..
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation

extension URL {
    
    static var base: URL {
        guard let basePath = Bundle.main.infoDictionary?["API base path"] as? String else {
            fatalError("API Base path doesn't exist in Info.plist")
        }
        
        guard let baseURL = URL(string: basePath) else {
            fatalError("API Base path in Info.plist is not valid")
        }
        return baseURL
    }
}
