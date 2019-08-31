import Foundation

enum RequestMethod: String {
    case DELETE
    case GET
    case POST
    case PUT
    case HEAD
    case PATCH
}

enum APIVersion: String {
    case v1 = "/api/v1"
    case v2 = "/api/v2"
    case none = ""
}

struct Resource<T> {
    let path: String
    var method: RequestMethod = .GET
    var headers: [String: String] = [:]
    var requestBody: [String: Any] = [:]
    var queryItems: [URLQueryItem]?
    var api: APIVersion = .none
}

extension Resource {
    
    init(path: String, method: RequestMethod = .GET) {
        self.path = path
        self.method = method
    }
}

/// Used when HTTP response body is empty
struct EmptyResponse: Codable { }
