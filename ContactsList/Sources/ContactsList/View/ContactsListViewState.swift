import Entities

public struct ContactsListViewState {
    var isButtonEnabled: Bool
    var contacts: [ConctactCellViewState]
}

extension ContactsListViewState {
    static let starting = ContactsListViewState(
        isButtonEnabled: false,
        contacts: []
    )
}
