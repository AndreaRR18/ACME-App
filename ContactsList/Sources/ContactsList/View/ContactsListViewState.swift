import Entities

public struct ContactsListViewState {
    var contacts: [ConctactCellViewState]
}

extension ContactsListViewState {
    static let starting = ContactsListViewState(contacts: [])
}
