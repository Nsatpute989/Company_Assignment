

import Foundation

protocol AuthProtocol {
    func doAuthenticate(user: AuthModel, type: AuthType)
}

class AuthenticationViewModel: AuthProtocol, ObservableObject {
    
    @Published var loggedInStatus: Bool = false
    @Published var registrationFailedResult: String = ""
    
    private let apiService: AuthenticationAPIProtocol
    
    init(_ service: AuthenticationAPIProtocol = AuthenticationAPIService()) {
        self.apiService = service
    }
    
    //MARK: Method
    
    func doAuthenticate(user: AuthModel, type: AuthType) {
        if let validationMessage = ValidateFields.validateUserField(user) {
            registrationFailedResult = validationMessage
        } else {
            resetFields()
            Task {
                let result =  await apiService.authenticate(with: user, type: type)
                switch result {
                case .success:
                    updateLoggedInStatus()
                case let .failure(error):
                    updateErrorStatus(error: error)
                }
            }
        }
    }
    
    private func resetFields() {
        registrationFailedResult = ""
    }
    
    private func updateErrorStatus(error: Error) {
        DispatchQueue.main.async {
            let authError = error as? AppError
            self.registrationFailedResult = authError?.error ?? error.localizedDescription
            self.loggedInStatus = false
        }
    }
    
    private func updateLoggedInStatus() {
        DispatchQueue.main.async {
            self.loggedInStatus = true
        }
    }
}
