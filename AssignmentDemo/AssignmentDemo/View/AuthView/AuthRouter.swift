

import Foundation


enum AuthRouter {
    case login(request: AuthModel)
    case register(request: AuthModel)
}

extension AuthRouter: APIEndPoint {

    var apiPath: String {
        switch self {
        case .login:
            return "/api/login"
        case .register:
            return "/api/register"
        }
    }
    
    var urlString: String {
        AppConstants.BASE_URL + apiPath
    }
    
    var httpMethod: RequestMethod {
        return .post
    }
}
