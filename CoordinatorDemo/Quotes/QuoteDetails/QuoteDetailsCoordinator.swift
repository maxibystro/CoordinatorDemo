import UIKit

class QuoteDetailsCoordinator: Coordinator {
    
    private let quoteItem: QuoteItem
    
    init(quoteItem: QuoteItem, context: CoordinatorContext) {
        self.quoteItem = quoteItem
        let quoteDetailsViewController = QuoteDetailsCoordinator.storyboard.instantiateViewController(withIdentifier: IBIdentifiers.quoteDetailsControllerID) as! QuoteDetailsViewController
        super.init(viewController: quoteDetailsViewController, context: context)
        quoteDetailsViewController.quoteItem = quoteItem
        quoteDetailsViewController.profileTapHandler = { [weak self] in
            self?.showCompanyProfile()
        }
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard.init(name: IBIdentifiers.mainStoryboardName, bundle: nil)
    }
    
    private func showCompanyProfile() {
        let profileViewController = QuoteDetailsCoordinator.storyboard.instantiateViewController(withIdentifier: IBIdentifiers.companyProfileControllerID) as! CompanyProfileViewController
        profileViewController.companyName = quoteItem.companyName
        profileViewController.companyOverview = quoteItem.companyOverview
        navigationRouter?.pushViewController(profileViewController, animated: true, completion: nil)
    }
}
