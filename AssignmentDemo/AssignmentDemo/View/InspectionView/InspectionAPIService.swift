

import Foundation

protocol InspectionAPIProtocol {
    func startInspection() async -> Result<InspectionResponse, Error>
    func submitInspection(inspection: InspectionResponse) async -> Result<Bool, Error>
}

class InspectionAPIService: InspectionAPIProtocol {
    
    func startInspection() async -> Result<InspectionResponse, Error> {
        
        await withCheckedContinuation { continuation in
            
            NetworkManager.shared.executeRequest(endPoint: InspectionRouter.startInspection) { (result: Result<InspectionResponse, Error>) in
                switch result {
                case let .success(response):
                    print("Response  \(response)" )
                    continuation.resume(returning: .success(response))
                case let .failure(error):
                    print("Error  \(error)" )
                    continuation.resume(returning: .failure(error))
                }
            }
        }
    }
    
    func submitInspection(inspection: InspectionResponse) async -> Result<Bool, Error> {
        
        await withCheckedContinuation { continuation in
            NetworkManager.shared.executeRequest(endPoint: InspectionRouter.submitInspection, requestModel: inspection) { result in
                
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
