import UIKit

class LoginCoordinator: Coordinator {
    
    init(context: CoordinatorContext) {
        let storyboard = UIStoryboard.init(name: IBIdentifiers.mainStoryboardName, bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: IBIdentifiers.loginControllerID)
        super.init(viewController: loginViewController, context: context)
    }
}
