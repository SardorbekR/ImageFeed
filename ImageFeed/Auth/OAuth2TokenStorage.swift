import Foundation

final class OAuth2TokenStorage {
    // MARK: - Public Properties

    var token: String? {
        get {
            UserDefaults.standard.string(forKey: "bearerToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bearerToken")
        }
    }
}
