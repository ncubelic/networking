//
//  UIAlertController+ErrorHandler.swift
//  Networking
//
//  Created by Nikola on 17.8.2019..
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation
import UIKit

public typealias Handler = () -> Void

extension UIAlertController {
    
    convenience init(alertModel: AlertModel, buttonTitle: String? = nil, handler: Handler? = nil) {
        self.init(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        self.addAction(
            UIAlertAction(title: buttonTitle ?? "OK", style: .default) { _ in
                handler?()
            }
        )
    }
}
