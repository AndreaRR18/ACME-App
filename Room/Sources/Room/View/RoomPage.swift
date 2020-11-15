import Foundation
import UIKit
import Architecture

public class RoomPage: UIViewController, PageType {
    
    public typealias ViewState = RoomViewState
    public typealias Presenter = RoomPresenter
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("CLOSE", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let rearCameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let firstContactCameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let secondContactCameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    private let thirdContactCameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let fourthContactCameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    public var presenter: RoomPresenter?
    public let environment: Environment
    
    public init(environment: Environment) {
        self.environment = environment
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RoomPresenter(
            interactor: RoomInteractor(),
            router: RoomRouterImpl(
                router: self
            ),
            update: update
        )
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        switch environment.selectedContacts.count {
        case 1:
            setupOneContact()
        case 2:
            setupTwoContacts()
        case 3:
            setupThreeContacts()
        case 4:
            setupFourContacts()
        default:
            fatalError("You can't show more than four contacts")
        }
        setupRearCamera()
        setupCloseButton()
    }
    
    public func update(_ value: RoomViewState) {
        
    }
    
    @objc func closeButtonTapped() {
        presenter?.closeRoom()
    }
    
    private func setupCloseButton() {
        closeButton.removeFromSuperview()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupRearCamera() {
        rearCameraView.removeFromSuperview()
        rearCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rearCameraView)
        NSLayoutConstraint.activate([
            rearCameraView.heightAnchor.constraint(equalToConstant: 80),
            rearCameraView.widthAnchor.constraint(equalToConstant: 80),
            rearCameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            rearCameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupOneContact() {
        firstContactCameraView.removeFromSuperview()
        firstContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstContactCameraView)
        NSLayoutConstraint.activate([
            firstContactCameraView.topAnchor.constraint(equalTo: view.topAnchor),
            firstContactCameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstContactCameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            firstContactCameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTwoContacts() {
        firstContactCameraView.removeFromSuperview()
        firstContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstContactCameraView)
        NSLayoutConstraint.activate([
            firstContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            firstContactCameraView.topAnchor
                .constraint(equalTo: view.topAnchor),
            firstContactCameraView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            firstContactCameraView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
        
        secondContactCameraView.removeFromSuperview()
        secondContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondContactCameraView)
        NSLayoutConstraint.activate([
            secondContactCameraView.topAnchor
                .constraint(equalTo: firstContactCameraView.bottomAnchor),
            secondContactCameraView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            secondContactCameraView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor),
            secondContactCameraView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupThreeContacts() {
        firstContactCameraView.removeFromSuperview()
        secondContactCameraView.removeFromSuperview()
        thirdContactCameraView.removeFromSuperview()
        
        firstContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstContactCameraView)
        secondContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondContactCameraView)
        thirdContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thirdContactCameraView)
        
        NSLayoutConstraint.activate([
            firstContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            firstContactCameraView.topAnchor
                .constraint(equalTo: view.topAnchor),
            firstContactCameraView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            firstContactCameraView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            secondContactCameraView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            secondContactCameraView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor),
            secondContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            secondContactCameraView.widthAnchor
                .constraint(equalToConstant: view.bounds.width/2)
        ])
        
        NSLayoutConstraint.activate([
            thirdContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            thirdContactCameraView.widthAnchor
                .constraint(equalToConstant: view.bounds.width/2),
            thirdContactCameraView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor),
            thirdContactCameraView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupFourContacts() {
        
        firstContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstContactCameraView)
        
        secondContactCameraView.removeFromSuperview()
        secondContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondContactCameraView)
        
        thirdContactCameraView.removeFromSuperview()
        thirdContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thirdContactCameraView)
        
        fourthContactCameraView.removeFromSuperview()
        fourthContactCameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fourthContactCameraView)
        
        
        NSLayoutConstraint.activate([
            firstContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            firstContactCameraView.widthAnchor
                .constraint(equalToConstant: view.bounds.width/2),
            firstContactCameraView.topAnchor
                .constraint(equalTo: view.topAnchor),
            firstContactCameraView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            secondContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            secondContactCameraView.widthAnchor
                .constraint(equalToConstant: view.bounds.width/2),
            secondContactCameraView.topAnchor
                .constraint(equalTo: view.topAnchor),
            secondContactCameraView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            thirdContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            thirdContactCameraView.widthAnchor
                .constraint(equalToConstant: view.bounds.width/2),
            thirdContactCameraView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor),
            thirdContactCameraView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            fourthContactCameraView.heightAnchor
                .constraint(equalToConstant: view.bounds.height/2),
            fourthContactCameraView.widthAnchor
                .constraint(equalToConstant: view.bounds.width/2),
            fourthContactCameraView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor),
            fourthContactCameraView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
    }
}
