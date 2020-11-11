import UIKit

public protocol Presentable: class {
    func presented() -> UIViewController
}
