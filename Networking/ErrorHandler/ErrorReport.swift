//
//  ErrorReport.swift
//  Networking
//
//  Created by Niksa on 16/08/2019.
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation

public struct ErrorReport: Error {
    
    var cause: Cause
    var data: Data?
}

extension ErrorReport {
    
    func alertable() -> AlertModel {
        switch cause {
        case .noData:
            return AlertModel(title: "Error", message: "No data")
        case .undecodable:
            return AlertModel(title: "Error", message: "Could not decode data")
        case .unauthorized:
            return AlertModel(title: "Error", message: "Unauthorized")
        case .serverError:
            return AlertModel(title: "Error", message: "Server error")
        case .serviceUnavailable:
            return AlertModel(title: "503", message: "Service Temporarily Unavailable")
        case .badRequest:
            return AlertModel(title: "Error", message: "Bad request")
        case .resourceNotFound:
            return AlertModel(title: "Error", message: "Resource not found")
        case .appOutdated:
            guard
                let data = data,
                let preconditionFailed: PreconditionFailed = data.decoded() else {
                    return .unknownError
            }
            return AlertModel(title: "Application out of date", message: preconditionFailed.description)
        case .invalidCredentials:
            guard
                let data = data,
                let unprocessableEntity: UnprocessableEntity = data.decoded() else {
                    return .unknownError
            }
            let message = unprocessableEntity.errors?.credentials?.first ?? "Unknown error occurred"
            return AlertModel(title: "Error", message: message)
        case .unconfirmedAccount:
            return AlertModel(title: "Error", message: "Unconfirmed account")
        default:
            return .unknownError
        }
    }
}
