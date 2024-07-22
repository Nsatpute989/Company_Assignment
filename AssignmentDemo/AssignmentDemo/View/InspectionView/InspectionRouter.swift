

import Foundation

enum InspectionRouter {
    case startInspection
    case submitInspection
}

extension InspectionRouter: APIEndPoint {
   
    var apiPath: String {
        switch self {
        case .startInspection:
            return "/api/inspections/start"
        case .submitInspection:
            return "/api/inspections/submit"
        }
    }
    
    var httpMethod: RequestMethod {
        switch self {
        case .startInspection:
            return .get
        case .submitInspection:
            return .post
        }
    }
    
    var urlString: String {
        AppConstants.BASE_URL + apiPath
    }
}
