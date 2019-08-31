//
//  Data+NetworkManager.swift
//  Networking
//
//  Created by Nikola on 17.8.2019..
//  Copyright © 2019 Lion Code. All rights reserved.
//

import Foundation

/// Extension for Decoding HTTP response using Codable
extension Data {
    
    func decoded<T: Decodable>(using decoder: JSONDecoder = JSONDecoder()) -> T? {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: self)
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            }
            // check if response is empty
            if self.isEmpty {
                return EmptyResponse() as? T
            }
            if let decodingError = error as? DecodingError {
                print(decodingError)
            }
            return nil
        }
    }
}
