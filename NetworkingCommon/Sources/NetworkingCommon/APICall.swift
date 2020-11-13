import Foundation

public protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String:String]? { get }
    func body() throws -> Data?
}

public enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}

extension APICall {
    public func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path)
            else { throw APIError.invalidURL }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = headers?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let urlComponents = components?.url
            else { throw APIError.invalidURL }
        
        var request = URLRequest(url: urlComponents)
        request.httpMethod = method
        
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}


public typealias HTTPCode = Int
public typealias HTTPCodes = Range<HTTPCode>

public extension HTTPCodes {
    static let success = 200 ..< 300
}
