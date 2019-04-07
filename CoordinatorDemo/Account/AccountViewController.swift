import UIKit

class AccountViewController: UIViewController {
    
    private let loginModel = LoginModel.instance
    
    @IBOutlet private weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginModelDidChangeState), name: LoginModel.didChangeStateNotification, object: loginModel)
        updateUsername()
    }
    
    private func updateUsername() {
        usernameLabel.text = loginModel.username ?? "Guest"
    }
    
    @IBAction func onLogoutButtonTap(_ sender: Any) {
        loginModel.logout()
    }
    
    @objc private func onLoginModelDidChangeState() {
        updateUsername()
    }
}
