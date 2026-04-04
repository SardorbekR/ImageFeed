import Foundation

final class OAuth2TokenStorage {
    // MARK: - Private Properties

    private let tokenKey = "bearerToken"

    // MARK: - Public Properties

    var token: String? {
        get {
            UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}
