

import Foundation

protocol APIEndPoint {
    var httpMethod: RequestMethod { get }
    var urlString: String { get }
}
