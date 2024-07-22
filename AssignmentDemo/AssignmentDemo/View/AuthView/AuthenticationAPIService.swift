

import Foundation

enum AuthType {
    case login
    case register
}

protocol AuthenticationAPIProtocol {
    func authenticate(with credential: AuthModel, type: AuthType) async -> Result<Bool, Error>
}


class AuthenticationAPIService: AuthenticationAPIProtocol {
    
    func authenticate(with credential: AuthModel, type: AuthType = .login) async -> Result<Bool, Error> {
        await withCheckedContinuation { continuation in
            
            let endPoint = (type == .login) ? AuthRouter.login(request: credential) : AuthRouter.register(request: credential)
            NetworkManager.shared.executeRequest(endPoint: endPoint, requestModel: credential) { result in
                
                switch result {
                case .success:
                    continuation.resume(returning: .success(true))
                case let .failure(error):
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
    
}

