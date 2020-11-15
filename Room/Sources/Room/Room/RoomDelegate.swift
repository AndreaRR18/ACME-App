public protocol RoomDelegate {
    func didConnect()
    func didDisconnect()
    func didAddStrem(_ stream: Stream)
    func didRemoveSteram(_ stream: Stream)
}
