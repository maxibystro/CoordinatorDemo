import UIKit

/**
 Manages a fragment of navigation controller's view controllers stack from the next to the router's root view controller and
 up to the child's root view controller or to the top of the stack if child does not exist.
 Every NavigationRouter can have a single child. The child manages the next fragment in the direction of the stack top.
 
 Navigation router does NOT contain any BUSINESS LOGIC. Navigation routers connected with parent-child relashionship form
 a set of wrappers around single navigation controller.
 
 How to use it?
 
 Scenario 1. Coordinator A (let's call it A) is going to create child Coordinator B and present it in a separate
 navigation controller (UINavigationController or CustomNavigationController).
 1. Coordinator A creates Navigation Controller with no root controller.
 2. Coordinator A creates NavigationRouterImpl with Navigation Controller from 1.
 3. Coordinator A created child coordinator B with router from 2 in its context.
 4. Coordinator A sets view controller of coordinator B as a root view controller to the router.
 
 Scenario 2. Coordinator B is going to create child Coordinator C and present it in the same navigation stack.
 1. Coordinator B creates child NavigationRouter for its navigationRouter: context.navigationRouter?.createChild().
 2. Coordinator B created child coordinator C with child router from 1.
 3. Coordinator B pushes view controller of coordinator C to navigation stack using its router.
    Coordinator B is responsible for presenting the view controller of coordinator C, so it pushes controller using router
    from context of coordinator B.
 
 */
@objc
public protocol NavigationRouter {
    
    var child: NavigationRouter? { get }
    @discardableResult
    func createChild() -> NavigationRouter
    func removeChild(animated: Bool)
    var onChildDismiss: (() -> Void)? { get set }
    
    /// View controllers starting from the next to the root and up to the child's root (if exists).
    var viewControllers: [UIViewController] { get }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func popToRootViewController(animated: Bool, completion: (() -> Void)?)
    func popViewController(animated: Bool, completion: (() -> Void)?)
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
}
