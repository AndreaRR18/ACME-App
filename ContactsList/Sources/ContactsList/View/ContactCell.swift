import UIKit
import Architecture
import FunctionalKit

class ContactCell: UITableViewCell, Updatable {
    
    typealias UpdateType = ConctactCellViewState
    
    static let identifier = "ContactCell"
    static let height: CGFloat = 90
    
    private var contactImageView = UIImageView()
    private var contactLabel = UILabel()
    private var selectedLabe: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Added"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedLabe.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contactImageView)
        contentView.addSubview(contactLabel)
        contentView.addSubview(selectedLabe)
        
        setupImage()
        setupLabel()
        setupSelectedImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ value: ConctactCellViewState) {
        contactImageView.image = UIImage(data: value.image)
        contactLabel.text = "\(value.firstName) \(value.lastName)"
        selectedLabe.isHidden = value.isSelected.not
    }
    
    private func setupImage() {
        NSLayoutConstraint.activate([
            contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contactImageView.heightAnchor.constraint(equalToConstant: 30),
            contactImageView.widthAnchor.constraint(equalToConstant: 30),
            contactImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupLabel() {
        NSLayoutConstraint.activate([
            contactLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            contactLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupSelectedImage() {
        NSLayoutConstraint.activate([
            selectedLabe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            selectedLabe.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
