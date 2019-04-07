import UIKit

class LoginViewController: UIViewController {
    
    private let loginModel = LoginModel.instance
    
    @IBOutlet private weak var loginWithNameButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBAction func onLoginWithNameTap(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        loginModel.login(name: name)
    }
    
    @IBAction func onLoginAsGuest(_ sender: Any) {
        loginModel.login()
    }
}
