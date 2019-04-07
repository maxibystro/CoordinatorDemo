import UIKit

/**
 See comments for NavigationRouter first.
 
 Router is responsible for creating its child. Only the first (root) router can be created with public initializer.
 */
@objcMembers
public final class NavigationRouterImpl: NSObject, NavigationRouter, NavigationControllerAdapterDelegate {

    public let navigationController: NavigationControllerAdapter
    public var rootViewController: UIViewController? {
        get {
            return _rootViewController
        }
        set {
            guard let newValue = newValue else {
                fatalError("Root view controller can not be nil")
            }
            setRootViewController(newValue, animated: false)
        }
    }
    private var _rootViewController: UIViewController?
    private var unwrappedRootViewController: UIViewController {
        checkRootViewController()
        return _rootViewController!
    }
    
    public private(set) var child: NavigationRouter?
    private var childImpl: NavigationRouterImpl? {
        return child as? NavigationRouterImpl
    }
    public var onChildDismiss: (() -> Void)?
    
    public var viewControllers: [UIViewController] {
        let nextToRootIndex = indexOfRootViewController() + 1
        if nextToRootIndex >= stack.count {
            return []
        }
        if let childRoot = childImpl?.rootViewController, let childRootIndex = index(of: childRoot, inRange: nextToRootIndex..<stack.count) {
            return Array(stack[nextToRootIndex...childRootIndex])
        }
        return Array(stack[nextToRootIndex...stack.count - 1])
    }
    private var stack: [UIViewController] {
        return navigationController.viewControllers
    }
    
    public convenience init(navigationControllerAdapter navigationController: NavigationControllerAdapter) {
        self.init(navigationController: navigationController, initial: true)
    }
    
    private init(navigationController: NavigationControllerAdapter, initial: Bool) {
        self.navigationController = navigationController
        super.init()
        if initial {
            navigationController.delegate = self
        }
    }
    
    public func setRootViewController(_ rootViewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard _rootViewController == nil else {
            fatalError("Replacing of root view controller is not supported yet")
        }
        _rootViewController = rootViewController
        internalPush(rootViewController, animated: animated, completion: completion)
    }
    
    private func checkRootViewController() {
        guard _rootViewController != nil else {
            fatalError("Navigation router must have a root view controller")
        }
    }
    
    public func createChild() -> NavigationRouter {
        checkRootViewController()
        child = NavigationRouterImpl(navigationController: navigationController, initial: false)
        return child!
    }
    
    public func removeChild(animated: Bool) {
        guard let childImpl = childImpl else {
            return
        }
        let childRootViewController = childImpl.rootViewController
        self.child = nil
        if let childRootViewController = childRootViewController {
            if let index = index(of: childRootViewController), index > 0 {
                let prevViewController = stack[index - 1]
                popToViewController(prevViewController, animated: animated, completion: onChildDismiss)
            } else {
                assertionFailure("Attempt ro remove child router which root view controller is not presented is stack")
            }
        }
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard _rootViewController != nil else {
            assertionFailure("Parent navigation router or a creator of the initial router must set a root view controller first")
            return
        }
        internalPush(viewController, animated: animated, completion: completion)
    }
    
    private func internalPush(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if let childImpl = childImpl {
            if childImpl.rootViewController == nil {
                childImpl.setRootViewController(viewController, animated: animated, completion: completion)
            } else {
                assertionFailure("The child router is responsible for managing navigation stack")
            }
        } else {
            navigationController.pushViewController(viewController, animated: animated, completion: completion)
        }
    }
    
    public func popToRootViewController(animated: Bool, completion: (() -> Void)? = nil) {
        popToViewController(unwrappedRootViewController, animated: animated, completion: completion)
    }
    
    public func popViewController(animated: Bool, completion: (() -> Void)? = nil) {
        guard stack.count > 1 else {
            return
        }
        let penultimateViewController = stack[stack.count - 2]
        popToViewController(penultimateViewController, animated: animated, completion: completion)
    }
    
    public func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        guard child == nil else {
            assertionFailure("The child router is responsible for managing navigation stack")
            return
        }
        guard let viewControllerIndex = index(of: viewController) else {
            return
        }
        let rootIndex = indexOfRootViewController()
        if viewControllerIndex >= rootIndex {
            navigationController.popToViewController(viewController, animated: animated, completion: completion)
        } else {
            assertionFailure("The parent router is responsible for managing this fragment of navigation stack")
        }
    }
    
    private func index(of viewController: UIViewController, inRange: CountableRange<Int>? = nil) -> Int? {
        let range = inRange ?? 0..<stack.count
        for i in range {
            if stack[i] === viewController {
                return i
            }
        }
        return nil
    }
    
    private func indexOfRootViewController() -> Int {
        guard let index = index(of: unwrappedRootViewController) else {
            fatalError("Root view controller was not found in stack")
        }
        return index
    }
    
    private func forgetChild() {
        onChildDismiss?()
        self.child = nil
    }
    
    // MARK: - NavigationControllerAdapterDelegate
    
    public func navigationController(_ navigationController: NavigationControllerAdapter, willShow viewController: UIViewController, animated: Bool) {
        if let childImpl = childImpl {
            if let childRootIndex = index(of: childImpl.unwrappedRootViewController), let viewControllerIndex = index(of: viewController), viewControllerIndex >= childRootIndex {
                childImpl.navigationController(navigationController, willShow: viewController, animated: animated)
            }
        }
    }
    
    public func navigationController(_ navigationController: NavigationControllerAdapter, didShow viewController: UIViewController, animated: Bool) {
        if let childImpl = childImpl {
            if let childRootIndex = index(of: childImpl.unwrappedRootViewController) {
                if let viewControllerIndex = index(of: viewController), viewControllerIndex >= childRootIndex {
                    childImpl.navigationController(navigationController, didShow: viewController, animated: animated)
                }
            } else {
                forgetChild()
            }
        }
    }
    
}
