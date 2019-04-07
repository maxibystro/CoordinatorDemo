import UIKit

class QuotesViewController: UITableViewController {
    
    private var quoteItems: [QuoteItem] = [QuoteItem(symbol: "AAPL", companyName: "Apple", companyOverview: "Apple makes money primarily by selling mobile phones, computers, and tablets to consumers worldwide.", price: 197),
                                           QuoteItem(symbol: "GOOG", companyName: "Google", companyOverview: "Google makes money from contextual advertising known as keyword advertising that is shown based on the type of search a user conducts.", price: 1207),
                                           QuoteItem(symbol: "IBM", companyName: "IBM", companyOverview: "IBM makes money primarily through the sale of Cognitive Solutions Software.", price: 143),
                                           QuoteItem(symbol: "AMZN", companyName: "Amazon", companyOverview: "Amazon is online retailer which sells electronics, books, retail consumer goods, music, games.", price: 1837),
                                           QuoteItem(symbol: "INTC", companyName: "Intel", companyOverview: "Intel manufactures and markets microprocessors used in servers, desktops and notebooks.", price: 55),
                                           QuoteItem(symbol: "AAL", companyName: "American Airliones", companyOverview: "American Airlines, Inc. (AA) is a major American airline headquartered in Fort Worth, Texas, within the Dallas-Fort Worth metroplex.", price: 34)]
    
    var quoteSelectionHandler: ((QuoteItem) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Quote", for: indexPath) as! QuoteTableViewCell
        let quoteItem = quoteItems[indexPath.row]
        cell.titleLabel.text = quoteItem.symbol
        cell.priceLabel.text = String(format: "%.2f", quoteItem.price)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = quoteItems[indexPath.row]
        quoteSelectionHandler?(item)
    }
}
