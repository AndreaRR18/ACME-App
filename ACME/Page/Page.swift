import UIKit

protocol Page: UIViewController {
    associatedtype ViewState
    func update(_ viewState: ViewState)
}

