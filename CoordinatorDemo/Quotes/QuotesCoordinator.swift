import UIKit

class QuotesCoordinator: Coordinator {
    
    init(context: CoordinatorContext) {
        let storyboard = UIStoryboard.init(name: IBIdentifiers.mainStoryboardName, bundle: nil)
        let quotesViewController = storyboard.instantiateViewController(withIdentifier: IBIdentifiers.quotesControllerID) as! QuotesViewController
        super.init(viewController: quotesViewController, context: context)
        quotesViewController.quoteSelectionHandler = { [weak self] item in
            self?.startQuoteDetailsFlow(forItem: item)
        }
    }
    
    private func startQuoteDetailsFlow(forItem item: QuoteItem) {
        guard let navigationRouter = navigationRouter else { return }
        let childContext = CoordinatorContext(navigationRouter: navigationRouter.createChild())
        let coordinator = QuoteDetailsCoordinator(quoteItem: item, context: childContext)
        addChildCoordinator(coordinator)
        navigationRouter.pushViewController(coordinator.viewController, animated: true, completion: nil)
        navigationRouter.onChildDismiss = { [weak self] in
            self?.removeChildCoordinator(coordinator)
        }
    }
}
