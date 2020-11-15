import Foundation

public struct ACMEStream: Stream {
    
    public var hasAudio: Bool
    public var hasVideo: Bool
    public var stream: Data
        
    public init(
        hasAudio: Bool,
        hasVideo: Bool,
        stream: Data
    ) {
        self.hasAudio = hasAudio
        self.hasVideo = hasVideo
        self.stream = stream
    }
}
