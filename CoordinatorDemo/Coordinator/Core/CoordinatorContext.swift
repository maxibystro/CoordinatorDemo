import Foundation

/**
 A coordinator context contains routers which can be used for presenting view controllers.
 */
@objcMembers
public class CoordinatorContext: NSObject {
    
    /// Handles push/pop transitions between view controllers.
    /// Several coordinators may share one navigation controller and such abstraction allows managing the navigation stack as if
    /// coordinator's view controller was the root view controller in the navigation stack and there was no controller before it.
    public let navigationRouter: NavigationRouter?
    
    /// TODO: alertRouter - router that is responsible for presenting alerts one after another
    
    public convenience override init() {
        self.init(navigationRouter: nil)
    }
    
    public init(navigationRouter: NavigationRouter?) {
        self.navigationRouter = navigationRouter
    }
    
}
