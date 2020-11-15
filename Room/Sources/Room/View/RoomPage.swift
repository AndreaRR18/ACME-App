import Foundation
import UIKit
import Architecture
import AVFoundation

public class RoomPage: UIViewController, PageType {
    
    public typealias ViewState = RoomViewState
    public typealias Presenter = RoomPresenter
    
    private let session = AVCaptureSession()
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
    
    private let firstContactCameraView: ContactView = {
        let view = ContactView()
        view.setupUI()
        return view
    }()
    
    private let secondContactCameraView: ContactView = {
        let view = ContactView()
        view.setupUI()
        return view
    }()
    
    private let thirdContactCameraView: ContactView = {
        let view = ContactView()
        view.setupUI()
        return view
    }()
    
    private let fourthContactCameraView: ContactView = {
        let view = ContactView()
        view.setupUI()
        return view
    }()
    
    public var presenter: RoomPresenter?
    public let environment: Environment
    public let networking: RoomNetworking
    
    private let room = Room()
    
    public init(
        environment: Environment,
        networking: RoomNetworking
    ) {
        self.environment = environment
        self.networking = networking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RoomPresenter(
            interactor: RoomInteractor(
                configuration: RoomInteractorConfiguration(
                    environment: environment,
                    repository: networking)),
            router: RoomRouterImpl(router: self),
            environment: environment,
            update: update
        )
        
        room.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        presenter?.startCall()
        setupRearCamera()
        setupCloseButton()
    }
    
    public func update(_ value: RoomViewState) {
        
        switch value.contacts.count {
        case 1:
            setupOneContact()
            let (contact, stream) = value.contacts[0].unwrap
            firstContactCameraView
                .update(ContactsViewState(
                            name: contact.firstName,
                            hasVideo: stream.hasVideo,
                            hasAudio: stream.hasAudio,
                            image: stream.stream)
                )
        case 2:
            setupTwoContacts()
            let (contact1, stream1) = value.contacts[0].unwrap
            firstContactCameraView
                .update(ContactsViewState(
                            name: contact1.firstName,
                            hasVideo: stream1.hasVideo,
                            hasAudio: stream1.hasAudio,
                            image: stream1.stream)
                )
            let (contact2, stream2) = value.contacts[1].unwrap
            secondContactCameraView
                .update(ContactsViewState(
                            name: contact2.firstName,
                            hasVideo: stream2.hasVideo,
                            hasAudio: stream2.hasAudio,
                            image: stream2.stream)
                )
        case 3:
            setupThreeContacts()
            let (contact1, stream1) = value.contacts[0].unwrap
            firstContactCameraView
                .update(ContactsViewState(
                            name: contact1.firstName,
                            hasVideo: stream1.hasVideo,
                            hasAudio: stream1.hasAudio,
                            image: stream1.stream)
                )
            let (contact2, stream2) = value.contacts[1].unwrap
            secondContactCameraView
                .update(ContactsViewState(
                            name: contact2.firstName,
                            hasVideo: stream2.hasVideo,
                            hasAudio: stream2.hasAudio,
                            image: stream2.stream)
                )
            let (contact3, stream3) = value.contacts[2].unwrap
            thirdContactCameraView
                .update(ContactsViewState(
                            name: contact3.firstName,
                            hasVideo: stream3.hasVideo,
                            hasAudio: stream3.hasAudio,
                            image: stream3.stream)
                )
        case 4:
            setupFourContacts()
            let (contact1, stream1) = value.contacts[0].unwrap
            firstContactCameraView
                .update(ContactsViewState(
                            name: contact1.firstName,
                            hasVideo: stream1.hasVideo,
                            hasAudio: stream1.hasAudio,
                            image: stream1.stream)
                )
            let (contact2, stream2) = value.contacts[1].unwrap
            secondContactCameraView
                .update(ContactsViewState(
                            name: contact2.firstName,
                            hasVideo: stream2.hasVideo,
                            hasAudio: stream2.hasAudio,
                            image: stream2.stream)
                )
            let (contact3, stream3) = value.contacts[2].unwrap
            thirdContactCameraView
                .update(ContactsViewState(
                            name: contact3.firstName,
                            hasVideo: stream3.hasVideo,
                            hasAudio: stream3.hasAudio,
                            image: stream3.stream)
                )
            let (contact4, stream4) = value.contacts[3].unwrap
            fourthContactCameraView
                .update(ContactsViewState(
                            name: contact4.firstName,
                            hasVideo: stream4.hasVideo,
                            hasAudio: stream4.hasAudio,
                            image: stream4.stream)
                )
        default:
            fatalError("You can't show more than four contacts")
        }
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
            rearCameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
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
        
        firstContactCameraView.removeFromSuperview()
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

extension RoomPage: RoomDelegate {
    public func didConnect() {
        
    }
    
    public func didDisconnect() {
        
    }
    
    public func didAddStrem(_ stream: Stream) {
        
    }
    
    public func didRemoveSteram(_ stream: Stream) {
        
    }
    
}
