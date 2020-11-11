import UIKit

extension UIViewController: Router {
    
    func present(_ module: Presentable, animated: Bool, _ completion: (() -> Void)?) {
        self.navigationController?.present(module.presented(), animated: animated, completion: completion)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        self.navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable, animated: Bool) {
        navigationController?.pushViewController(module.presented(), animated: animated)
    }
    
    func popModule(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func setAsRoot(_ module: Presentable, animated: Bool) {
        navigationController?.setViewControllers([module.presented()], animated: animated)
    }
    
    func popToRootModule(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
}

extension Router where Self: UIViewController {
    func present(_ module: Presentable, animated: Bool, _ completion: (() -> Void)?) {
        navigationController?.present(module.presented(), animated: animated, completion: completion)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable, animated: Bool) {
        navigationController?.pushViewController(module.presented(), animated: animated)
    }
    
    func popModule(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func setAsRoot(_ module: Presentable, animated: Bool) {
        navigationController?.setViewControllers([module.presented()], animated: animated)
    }
    
    func popToRootModule(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
