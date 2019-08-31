//
//  PreconditionFailed.swift
//  Networking
//
//  Created by Niksa on 16/08/2019.
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation

struct Credentials: Codable {
    let error: String?
}

struct Details: Codable {
    let credentials: [Credentials]?
}

struct Errors: Codable {
    let credentials: [String]?
}

struct UnprocessableEntity: Codable {
    let errors: Errors?
    let details: Details?
}

struct PreconditionFailed: Codable {
    var code: Int
    var description: String
}
