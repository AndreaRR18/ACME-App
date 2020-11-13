import UIKit

extension UIViewController: Presentable {
    public func presented() -> UIViewController {
        return self
    }
}

extension Presentable where Self: UIViewController {
    public func presented() -> Self {
        return self
    }
}
