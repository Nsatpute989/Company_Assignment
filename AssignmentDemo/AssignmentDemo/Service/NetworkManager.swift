//
import Foundation
enum RequestMethod: String {
    case get
    case post
    case put
    case delete
    
    var method: String { rawValue.uppercased() }
}



protocol NetworkManagerProtocol {
    func executeRequest<T: Decodable>(endPoint: APIEndPoint, completion: @escaping (Result<T, Error>) -> Void)
    func executeRequest<T: Encodable>(endPoint: APIEndPoint, requestModel: T?, completion: @escaping (Result<Bool, Error>) -> Void)
    
}

enum HttpErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidRequest
    case decodingError
}



class NetworkManager: NetworkManagerProtocol {

    
    let httpOkStatusCode = 200
    static let shared = NetworkManager()
    private init() {}
    
    
    func executeRequest<T: Decodable>(endPoint: APIEndPoint, completion: @escaping (Result<T, Error>) -> Void)  {
        
        guard let url = URL(string: endPoint.urlString) else {
            return completion(.failure(HttpErrors.invalidRequest))
        }
                              
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod.method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            guard error == nil else {
                completion(.failure(HttpErrors.invalidRequest))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == self.httpOkStatusCode, let responseData = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: responseData)
                    completion(.success(result))
                } catch {
                    completion(.failure(HttpErrors.decodingError))
                }
                
            } else {
                completion(.failure(HttpErrors.invalidResponse))
            }
        })
        task.resume()
    }
    
    func executeRequest<T: Encodable>(endPoint: APIEndPoint, requestModel: T?, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        // ============= End here ================
        guard let url = URL(string: endPoint.urlString) else {
            return completion(.failure(HttpErrors.invalidRequest))
        }
                              
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        
        if let param = requestModel {
            do {
                let data = try JSONEncoder().encode(param)
                request.httpBody = data
            } catch {
                print(error)
            }
            
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let str = String(data: data ?? Data(), encoding: .utf8)
            debugPrint("Response is --- \(String(describing: str))")
            guard error == nil else {
                completion(.failure(HttpErrors.invalidRequest))
                return
            }
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == self.httpOkStatusCode {
                completion(.success(true))
            } else if let responseData = data  {
                do {
                    let error = try JSONDecoder().decode(AppError.self, from: responseData)
                    completion(.failure(error))
                } catch {
                    completion(.failure(HttpErrors.decodingError))
                }
            } else {
                completion(.failure(HttpErrors.invalidResponse))
            }
        }
        
        task.resume()
    }
}

