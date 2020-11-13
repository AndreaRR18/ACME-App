public protocol Router {
    func presentPage(_ module: Presentable, animated: Bool, _ completion: (() -> Void)?)
    func dismissPage(animated: Bool, completion: (() -> Void)?)
    func pushPage(_ module: Presentable,
              animated: Bool)
    func popPage(animated: Bool)
    func setAsRoot(_ module: Presentable, animated: Bool)
    func popToRootPage(animated: Bool)
}
