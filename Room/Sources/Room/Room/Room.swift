class Room {
    
    var delegate: RoomDelegate?
    
    func connect() {
        delegate?.didConnect()
    }
    
    func disconnet() {
        delegate?.didConnect()
    }
    
}
