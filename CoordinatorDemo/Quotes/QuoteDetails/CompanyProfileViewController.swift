import UIKit

class CompanyProfileViewController: UIViewController {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var companyName: String? {
        didSet {
            title = companyName
        }
    }
    var companyOverview: String? {
        didSet {
            applyСompanyOverview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyСompanyOverview()
    }
    
    private func applyСompanyOverview() {
        guard isViewLoaded else { return }
        descriptionLabel.text = companyOverview
    }
}
