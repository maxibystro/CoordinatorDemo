import UIKit

/*
 Coordinator is responsible for managing one or more view controllers, and it will take
 care of the flow logic (flow is a group of screens with similar purpose e.g. registration).
 */
open class Coordinator: NSObject {
    
    /// Most transitions between view controllers can be done using routers from context.
    /// Note: every coordinator should use navigationRouter for push/pop transitions and must not use navigationController directly.
    public let context: CoordinatorContext
    
    /// Convinience property
    public var navigationRouter: NavigationRouter? {
        return context.navigationRouter
    }
    
    /// The first view controller in the flow.
    /// Parent coordinator is responsible for presenting it.
    public let viewController: UIViewController
    
    private var childCoordinators = [Coordinator]()
    
    public init(viewController: UIViewController, context: CoordinatorContext) {
        self.viewController = viewController
        self.context = context
    }
}

/// Managing the coordinator hierarchy

public extension Coordinator {
    
    public func addChildCoordinator(_ child: Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
    
    public func removeChildCoordinator(_ child: Coordinator) {
        if let index = childCoordinators.index(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
    
    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
}
