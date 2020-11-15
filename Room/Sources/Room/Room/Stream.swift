import Foundation

public protocol Stream {
    var hasAudio: Bool { get }
    var hasVideo: Bool { get }
    var stream: Data { get }
}
