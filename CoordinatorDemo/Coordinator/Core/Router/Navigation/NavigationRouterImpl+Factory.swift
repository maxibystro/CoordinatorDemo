import UIKit

public extension NavigationRouterImpl {
    
    @objc public convenience init(navigationController: UINavigationController) {
        self.init(navigationControllerAdapter: DefaultNavigationControllerAdapter(navigationController: navigationController))
    }
    
}
