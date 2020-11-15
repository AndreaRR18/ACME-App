import NetworkingCommon
import Entities
import RxSwift
import Foundation

public protocol RoomNetworking: WebRepository {
    func startCall(with: Contact) -> Observable<Result<Stream, ClientError>>
}

public struct RoomNetworkingImpl: RoomNetworking {
    
    public var session: URLSession
    public var baseURL: String
    
    public init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    public func startCall(with contact: Contact) -> Observable<Result<Stream, ClientError>> {
        let response: Observable<Result<WSRoomModel.Response, ClientError>> = call(endpoint: API.startCallWith(id: contact.id))
        
        return response.map { result -> Result<Stream, ClientError> in
            result.map { response in
                ACMEStream(
                    hasAudio: response.streamStatus.hasAudio,
                    hasVideo: response.streamStatus.hasVideo,
                    stream: response.streamStatus.stream)
            }
        }
    }
}

fileprivate extension RoomNetworkingImpl {
    enum API {
        case startCallWith(id: String)
    }
}

extension RoomNetworkingImpl.API: APICall {
    var path: String {
        switch self {
        case let .startCallWith(id: id):
            return "path/to/get/stream?contactid=\(id)"
        }
    }
    
    var method: String { "GET" }
    var headers: [String : String]? {
        ["jwt-token": "TEOANDADSKVAOSNFAKSL"]
    }
    
    func body() throws -> Data? { nil }
    
}

