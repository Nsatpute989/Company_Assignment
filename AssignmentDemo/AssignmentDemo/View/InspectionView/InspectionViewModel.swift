

import Foundation

protocol InspectionViewModelProtocol {
    func startInspection()
    func submitInspection()
}


class InspectionViewModel: ObservableObject, InspectionViewModelProtocol {
    
    @Published var inspectionResponse: InspectionResponse?
    @Published var areaName: String = ""
    @Published var inceptionType: String = ""
    @Published var categories: [Categories] = [Categories]()
    @Published var submitInspectionResult: String = ""
    @Published var showingAlert: Bool = false
    
    private let dataProvider: InspectionDataProviderProtocol
    
    init (dataProvider: InspectionDataProviderProtocol = InspectionDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func startInspection() {
        Task {
            let result = await dataProvider.fetchAllInspection()
            switch result {
            case let .success(response):
                publishValue(obj: response)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func publishValue(obj: InspectionResponse) {
        DispatchQueue.main.async { [self] in
            self.areaName = obj.inspection?.area?.name ?? ""
            self.inceptionType = obj.inspection?.inspectionType?.name ?? ""
            self.categories = obj.inspection?.survey?.categories ?? []
        }
    }
    
    func submitInspection() {
        Task {
            let result = await dataProvider.submitInspection()
            switch result {
            case .success:
                publishSubmitInspectionResult(success: true, error: "")
            case let .failure(error):
                debugPrint(error.localizedDescription)
                publishSubmitInspectionResult(success: false, error: error.localizedDescription)
            }
        }
    }
    
    private func publishSubmitInspectionResult(success: Bool, error: String) {
        DispatchQueue.main.async {
            if success {
                self.submitInspectionResult = AppConstants.inspectionSubmission
            } else {
                self.submitInspectionResult = error
            }
        }
    }
    
}
