import UIKit

public protocol PageType: UIViewController & Updatable {
    associatedtype ViewState
    associatedtype Presenter
    
    var presenter: Presenter? { get set }
    
    func update(_ viewState: ViewState)
}
