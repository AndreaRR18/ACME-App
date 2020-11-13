import UIKit
import RxSwift

final class ContactsListAdapter: NSObject {
    
    private weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            tableView?.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        }
    }
    
    var contactListViewState: [ConctactCellViewState] = [] {
        didSet {
            guard oldValue != contactListViewState else { return }
            tableView?.reloadData()
        }
    }
    
    func attach(tableView: UITableView) {
        self.tableView = tableView
    }
}

extension ContactsListAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactListViewState.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier) as? ContactCell
            else { fatalError("Error on dequeue") }
        cell.update(contactListViewState[indexPath.row])
        return cell
    }
    
}

extension ContactsListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
