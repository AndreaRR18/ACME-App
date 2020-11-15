import Entities
import RxSwift
import Architecture
import FunctionalKit

struct RoomInteractorConfiguration {
    let environment: Environment
    let repository: RoomNetworking
}

struct RoomInteractor {
    let configuration: RoomInteractorConfiguration
    
    func startCall(with contacts: [Contact]) -> Observable<[Pair<Contact, Stream>]> {
        Observable.combineLatest(
            contacts.map { contact in
                configuration.repository
                    .startCall(with: contact)
                    .compactMap { $0.toOptionalValue() }
                    .map { stream in  Pair(contact, stream) }
            }
        )
    }
}
