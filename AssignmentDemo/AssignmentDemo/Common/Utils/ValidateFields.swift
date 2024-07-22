

import Foundation

struct ValidateFields {
    static func validateUserField(_ user: AuthModel) -> String? {
        
        if let email = user.email, email.count == 0, let password = user.password, password.count == 0 {
            return AppConstants.emailPassValidateMsg
        }
        if let email = user.email, email.count == 0 {
            return AppConstants.emailValidateMsg
        }
        if let pass = user.password, pass.count == 0 {
            return AppConstants.passValidateMsg
        }
        return nil
    }
}


