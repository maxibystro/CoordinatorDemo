import UIKit

class DefaultNavigationControllerAdapter: NSObject {
    
    private let navigationController: UINavigationController
    
    var delegate: NavigationControllerAdapterDelegate?
    
    var viewControllers: [UIViewController] {
        get {
            return navigationController.viewControllers
        }
        set {
            navigationController.viewControllers = newValue
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }
}

extension DefaultNavigationControllerAdapter: NavigationControllerAdapter {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController.pushViewController(viewController, animated: animated)
        guard let completion = completion else { return }
        guard animated, let coordinator = navigationController.transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        navigationController.popToViewController(viewController, animated: animated)
        guard let completion = completion else { return }
        guard animated, let coordinator = navigationController.transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}

extension DefaultNavigationControllerAdapter: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        delegate?.navigationController(self, willShow: viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        delegate?.navigationController(self, didShow: viewController, animated: animated)
    }
}
