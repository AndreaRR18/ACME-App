import Foundation
import UIKit
import Architecture
import FunctionalKit

class ContactView: UIView, Updatable {
    typealias UpdateType = ContactsViewState
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let placeholderVideo: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "No video"
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        return label
    }()
    
    let muteLabel: UILabel = {
        let label = UILabel()
        label.text = "Mute"
        label.textColor = .black
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        return label
    }()
    
    func setupUI() {
        backgroundColor = .lightGray
        imageView.removeFromSuperview()
        placeholderVideo.removeFromSuperview()
        label.removeFromSuperview()
        muteLabel.removeFromSuperview()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderVideo.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        muteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(placeholderVideo)
        addSubview(label)
        addSubview(muteLabel)
        
        //Image
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        //Placeholder Image
        NSLayoutConstraint.activate([
            placeholderVideo.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderVideo.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        //Label
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 20),
            label.heightAnchor.constraint(equalToConstant: 100),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        //Mute image
        NSLayoutConstraint.activate([
            muteLabel.heightAnchor.constraint(equalToConstant: 20),
            muteLabel.heightAnchor.constraint(equalToConstant: 20),
            muteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            muteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func update(_ value: ContactsViewState) {
        if let data = value.image, value.hasVideo {
            imageView.isHidden = false
            imageView.image = UIImage(data: data)
            placeholderVideo.isHidden = true
        } else {
            imageView.isHidden = true
            placeholderVideo.isHidden = false
        }
        
        label.text = value.name
        muteLabel.isHidden = value.hasAudio.not
    }
}
