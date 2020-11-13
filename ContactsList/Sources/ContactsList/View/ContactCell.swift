import UIKit
import Architecture
import FunctionalKit

class ContactCell: UITableViewCell, Updatable {
    
    typealias UpdateType = ConctactCellViewState
    
    static let identifier = "ContactCell"
    static let height = 50

    private var contactImageView = UIImageView()
    private var contactLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 11.0, *) {
            buildUI()
        }
    }
    
    func update(_ value: ConctactCellViewState) {
        contactImageView.image = UIImage(data: value.image)
        contactLabel.text = "\(value.firstName) \(value.lastName)"
    }
    
    @available(iOS 11.0, *)
    private func buildUI() {
        addSubview(contactImageView)
        addSubview(contactLabel)
        
        NSLayoutConstraint.activate([
            contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contactImageView.heightAnchor.constraint(equalToConstant: 30),
            contactImageView.widthAnchor.constraint(equalToConstant: 30),
            contactImageView.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 1),
            
            contactLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            contactLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            contactLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 1)
        ])
    }
}
