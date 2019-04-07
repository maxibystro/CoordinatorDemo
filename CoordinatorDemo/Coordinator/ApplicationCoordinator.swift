import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let loginModel = LoginModel.instance
    private var loginCoordinator: LoginCoordinator?
    
    init() {
        let tabBarController = UITabBarController()
        super.init(viewController: tabBarController, context: CoordinatorContext())
        tabBarController.setViewControllers([createQuotesTab(), createAccountTab()], animated: false)
    }
    
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginModelDidChangeState), name: LoginModel.didChangeStateNotification, object: loginModel)
        if !loginModel.isLoggedOn {
            startLoginCoordinator(animated: false)
        }
    }
    
    private func createQuotesTab() -> UIViewController {
        let navigationController = UINavigationController()
        let navigationRouter = NavigationRouterImpl(navigationController: navigationController)
        let childContext = CoordinatorContext(navigationRouter: navigationRouter)
        let childCoordinator = QuotesCoordinator(context: childContext)
        addChildCoordinator(childCoordinator)
        navigationRouter.setRootViewController(childCoordinator.viewController, animated: false)
        navigationController.tabBarItem.image = UIImage(named: "QuotesIcon")
        return navigationController
    }
    
    private func createAccountTab() -> UIViewController {
        let storyboard = UIStoryboard.init(name: IBIdentifiers.mainStoryboardName, bundle: nil)
        let accountViewController = storyboard.instantiateViewController(withIdentifier: IBIdentifiers.accountControllerID)
        accountViewController.tabBarItem.image = UIImage(named: "AccountIcon")
        return UINavigationController(rootViewController: accountViewController)
    }
    
    @objc private func onLoginModelDidChangeState() {
        if !loginModel.isLoggedOn {
            startLoginCoordinator(animated: true)
        } else {
            stopLoginCoordinator()
        }
    }
    
    private func startLoginCoordinator(animated: Bool) {
        loginCoordinator = LoginCoordinator(context: CoordinatorContext())
        guard let loginCoordinator = loginCoordinator else { return }
        addChildCoordinator(loginCoordinator)
        viewController.present(loginCoordinator.viewController, animated: animated, completion: nil)
    }
    
    private func stopLoginCoordinator() {
        guard let loginCoordinator = loginCoordinator else { return }
        viewController.dismiss(animated: true, completion: nil)
        removeChildCoordinator(loginCoordinator)
        self.loginCoordinator = nil
    }
}
