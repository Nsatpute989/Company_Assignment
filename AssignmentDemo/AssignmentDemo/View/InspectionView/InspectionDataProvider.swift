

import Foundation

protocol InspectionDataProviderProtocol {
    func fetchAllInspection() async -> Result<InspectionResponse, Error>
    func submitInspection() async -> Result<Bool, Error>
}

struct InspectionDataProvider: InspectionDataProviderProtocol {
    
    private let apiService: InspectionAPIProtocol
    
    init (apiService: InspectionAPIProtocol = InspectionAPIService()) {
        self.apiService = apiService
    }
    
    func fetchAllInspection() async -> Result<InspectionResponse, Error> {
        
        if let response = PersistentFileManager.readJSONFromFile() {
            return .success(response)
        } else {
            let result = await apiService.startInspection()
    
            switch result {
            case let .success(response):
                PersistentFileManager.storeJSONDataLocally(response)
                return .success(response)
            case let .failure(error):
                return .failure(error)
            }
        }
        
    }
    
    
    func submitInspection() async -> Result<Bool, Error> {
        guard let response = PersistentFileManager.readJSONFromFile() else {
            return .failure(HttpErrors.invalidRequest)
        }
        let result = await apiService.submitInspection(inspection: response)
        switch result {
        case .success:
            PersistentFileManager.removeJSONFile()
            return .success(true)
        case let .failure(error):
            debugPrint(error.localizedDescription)
            return .failure(error)
        }
    }
    
}
