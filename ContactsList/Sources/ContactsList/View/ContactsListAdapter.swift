import UIKit
import RxSwift

final class ContactsListAdapter: NSObject {
    
    private weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            tableView?.allowsMultipleSelection = true
            tableView?.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        }
    }
    private weak var presenter: ContactsListPresenter?
    
    var contactListViewState: [ConctactCellViewState] = [] {
        didSet {
            guard oldValue != contactListViewState else { return }
            tableView?.reloadData()
        }
    }
    
    func attach(tableView: UITableView, presenter: ContactsListPresenter?) {
        self.tableView = tableView
        self.presenter = presenter
    }
}

extension ContactsListAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactListViewState.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier) as? ContactCell
            else { fatalError("Error on dequeue") }
        cell.update(contactListViewState[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ContactCell.height
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter?.removeLocalContact(contactListViewState[indexPath.row].contactsId)
        }
    }
}

extension ContactsListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.itemSelected(contactId: contactListViewState[indexPath.row].contactsId)
    }
    
}
