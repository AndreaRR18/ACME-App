import UIKit

extension UIViewController: Router {
    
    public func presentPage(_ module: Presentable, animated: Bool, _ completion: (() -> Void)?) {
        let destination = module.presented()
        destination.modalPresentationStyle = .fullScreen
        present(destination, animated: animated, completion: completion)
    }
    
    public func dismissPage(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func pushPage(_ module: Presentable, animated: Bool) {
        navigationController?.pushViewController(module.presented(), animated: animated)
    }
    
    public func popPage(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func setAsRoot(_ module: Presentable, animated: Bool) {
        navigationController?.setViewControllers([module.presented()], animated: animated)
    }
    
    public func popToRootPage(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
