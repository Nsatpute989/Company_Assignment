

import Foundation

struct AuthModel: Encodable {
    let email: String?
    let password: String?
}

struct AppError: Decodable, Error {
    let error: String?
}
