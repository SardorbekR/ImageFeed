import Foundation

final class OAuth2Service {
    // MARK: - Public Properties

    static let shared = OAuth2Service()

    // MARK: - Private Properties

    private let decoder = JSONDecoder()

    // MARK: - Private Initializer

    private init() {}

    // MARK: - Public Methods

    func fetchOAuthToken(
        code: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard let request = makeOAuthTokenRequest(code: code) else { return }
        URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try self.decoder.decode(
                        OAuthTokenResponseBody.self,
                        from: data
                    )
                    OAuth2TokenStorage().token = response.accessToken
                    completion(.success(response.accessToken))
                } catch {
                    print(
                        "OAuth2Service: decode error - \(error)"
                    )
                    completion(.failure(error))
                }
            case .failure(let error):
                print("OAuth2Service: network error - \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Private Methods

    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard
            var urlComponents = URLComponents(
                string: WebViewComponents.unsplashAccessTokenURLString
            )
        else {
            print("OAuth2Service: Error creating URLComponents")
            return nil
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]

        guard let url = urlComponents.url else {
            print("OAuth2Service: Error creating URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        return request
    }
}
