public protocol Router {
    func present(_ module: Presentable, animated: Bool, _ completion: (() -> Void)?)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable,
              animated: Bool)
    func popModule(animated: Bool)
    func setAsRoot(_ module: Presentable, animated: Bool)
    func popToRootModule(animated: Bool)
}
