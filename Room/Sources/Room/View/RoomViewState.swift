import Entities
import FunctionalKit

public struct RoomViewState {
    var contacts: [Pair<Contact, Stream>]
}

extension RoomViewState {
    static let starting = RoomViewState(contacts: [])
}
