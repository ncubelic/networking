//
//  ErrorHandler.swift
//  Networking
//
//  Created by Niksa on 16/08/2019.
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation
import UIKit

public typealias ErrorAction = (ErrorReport) -> Void

class ErrorHandler {
    
    let rootViewController: UIViewController
    
    private var defaultHandlerMap: [Cause: ErrorAction]?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    /// Handles error as default, which is predefined for every 'Cause'
    func handle(_ errorReport: ErrorReport) {
        handle(errorReport, handlerMap: getDefaultHandlerMap())
    }
    
    /// Handles error with custom map
    func handle(_ errorReport: ErrorReport, handlerMap: [Cause: ErrorAction]) {
        let performAction = handlerMap[errorReport.cause]
        performAction?(errorReport)
    }
    
    func assign(errorAction: @escaping ErrorAction, for causes: [Cause]) -> [Cause: ErrorAction] {
        var map: [Cause: ErrorAction] = [:]
        causes.forEach { map[$0] = errorAction }
        return map
    }
    
    func showAlert(with alertModel: AlertModel, buttonTitle: String? = nil, handler: Handler?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(alertModel: alertModel, buttonTitle: buttonTitle, handler: handler)
            self.rootViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func getDefaultHandlerMap() -> [Cause: ErrorAction] {
        guard let defaultHandlerMap = defaultHandlerMap else {
            var map: [Cause: ErrorAction] = [:]
            
            map.merge(assign(errorAction: { self.showAlert(with: $0.alertable(), buttonTitle: "OK", handler: nil) },
                             for: [.noData,
                                   .undecodable,
                                   .badRequest,
                                   .serverError,
                                   .invalidCredentials,
                                   .other,
                                   .resourceNotFound,
                                   .unauthorized,
                                   .unconfirmedAccount,
                                   .serviceUnavailable]),
                      uniquingKeysWith: firstErrorAction(_:_:))
            
            self.defaultHandlerMap = map
            return map
        }
        return defaultHandlerMap
    }
    
    private func firstErrorAction(_ a1: @escaping ErrorAction, _ a2: @escaping ErrorAction) -> ErrorAction {
        return a1
    }
}
