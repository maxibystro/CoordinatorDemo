import UIKit

public protocol NavigationControllerAdapterDelegate: class {
    
    func navigationController(_ navigationController: NavigationControllerAdapter, willShow viewController: UIViewController, animated: Bool)
    func navigationController(_ navigationController: NavigationControllerAdapter, didShow viewController: UIViewController, animated: Bool)
    
}

public protocol NavigationControllerAdapter: class {
    
    var delegate: NavigationControllerAdapterDelegate? { get set }
    var viewControllers: [UIViewController] { get set }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
}
