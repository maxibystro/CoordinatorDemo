import Foundation

class LoginModel {
    
    static let didChangeStateNotification = Notification.Name(rawValue: "loginModelDidChangeState")
    
    static let instance = LoginModel()
    
    var isLoggedOn = false {
        didSet {
            if oldValue != isLoggedOn {
                NotificationCenter.default.post(name: LoginModel.didChangeStateNotification, object: self)
            }
        }
    }
    private (set) var username: String?
    
    var isLoggedOnAsGuest: Bool {
        return isLoggedOn && username == nil
    }
    var isLoggedOnAsIdentified: Bool {
        return isLoggedOn && username != nil
    }
    
    private init() {}
    
    func logout() {
        username = nil
        isLoggedOn = false
    }
    
    /// Login as guest
    func login() {
        if isLoggedOnAsIdentified {
            logout()
        }
        username = nil
        isLoggedOn = true
    }
    
    /// Login as identified user
    func login(name: String) {
        if isLoggedOnAsGuest {
            logout()
        }
        username = name
        isLoggedOn = true
    }
    
}
