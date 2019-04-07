import UIKit

class QuoteDetailsViewController: UIViewController {
    
    @IBOutlet private weak var priceLabel: UILabel!
    
    var profileTapHandler: (() -> Void)?
    
    var quoteItem: QuoteItem? {
        didSet {
            applyQuoteItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyQuoteItem()
    }
    
    private func applyQuoteItem() {
        guard isViewLoaded else { return }
        if let quoteItem = quoteItem {
            title = quoteItem.symbol
            priceLabel.text = String(format: "%.2f", quoteItem.price)
        } else {
            title = "No item"
            priceLabel.text = "-"
        }
    }
    
    @IBAction private func onProfileButtonTap(_ sender: Any) {
        profileTapHandler?()
    }
}
