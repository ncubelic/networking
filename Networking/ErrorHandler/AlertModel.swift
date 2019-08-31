//
//  AlertModel.swift
//  Networking
//
//  Created by Niksa on 16/08/2019.
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation

struct AlertModel {
    var title: String
    var message: String
}

extension AlertModel {
    
    static var unknownError: AlertModel {
        return AlertModel(title: "Error", message: "Unknown error occurred")
    }
}
