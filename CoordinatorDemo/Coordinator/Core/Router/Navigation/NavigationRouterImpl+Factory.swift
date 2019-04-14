import UIKit

public extension NavigationRouterImpl {
    
    public convenience init(navigationController: UINavigationController) {
        self.init(navigationControllerAdapter: DefaultNavigationControllerAdapter(navigationController: navigationController))
    }
    
}
