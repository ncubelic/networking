import Foundation

class NetworkConfiguration {
    
    private(set) var baseURL: URL
    private(set) var requiredHTTPHeaders: [String: String]
    private(set) var session: URLSession
    
    init(baseURL: URL = .base, requiredHTTPHeaders: [String: String] = [:], session: URLSession = .shared) {
        self.baseURL = baseURL
        self.requiredHTTPHeaders = requiredHTTPHeaders
        self.session = session
    }
    
    /// Adds new HTTP header to the requiredHeaders dictionary
    /// If key exists, it will be overwriten with new value
    func addRequiredHTTPHeader(value: String, forKey: String) {
        self.requiredHTTPHeaders[forKey] = value
    }
    
    /// Removes all values from requredHTTPHeaders dictionary
    /// Adds all headers which are required in all requests
    func resetRequiredHTTPHeaders() {
        self.requiredHTTPHeaders.removeAll()
    }
}

extension NetworkConfiguration {
    
    /// Returns configuration with default initializer parameters
    static var `default`: NetworkConfiguration {
        let configuration = NetworkConfiguration()
        configuration.addRequiredHTTPHeader(value: "application/json", forKey: "Content-Type")
        configuration.addRequiredHTTPHeader(value: "application/json", forKey: "Accept")
        return configuration
    }
}
