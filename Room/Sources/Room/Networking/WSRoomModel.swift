import Foundation

enum WSRoomModel {
    struct Request: Encodable {
        var contactId: String
    }
    
    struct Response: Decodable {
        var streamStatus: StreamStatus
    }
    
    struct StreamStatus: Decodable {
        var id: String
        var hasVideo: Bool
        var hasAudio: Bool
        var stream: Data
    }
}
