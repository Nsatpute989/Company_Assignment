import Foundation

class PersistentFileManager {
    
    
    static func storeJSONDataLocally(_ inspection: InspectionResponse) {
        do {
            let jsonData = try JSONEncoder().encode(inspection)
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("inspection.json")
            try jsonData.write(to: fileURL)
            print("JSON data saved locally: \(fileURL)")
        } catch {
            print("Error saving JSON data locally: \(error)")
        }
    }
    
    static func readJSONFromFile() -> InspectionResponse? {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("inspection.json") {
            do {
                print("JSON data saved locally: \(fileURL)")
                let jsonData = try Data(contentsOf: fileURL)
                let inspection = try JSONDecoder().decode(InspectionResponse.self, from: jsonData)
                return inspection
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
        return nil
    }
    
    static func modifyData(question: Questions, answerId: Int?, category: Categories) {
        
        var inspection = PersistentFileManager.readJSONFromFile()?.inspection
        
        let categoryIndex = inspection?.survey?.categories?.firstIndex(where: { $0.id == category.id }) ?? 0
        
        let questinonIndex = inspection?.survey?.categories?[categoryIndex].questions?.firstIndex(where: { $0.id == question.id }) ?? 0
        
        inspection?.survey?.categories?[categoryIndex].questions?[questinonIndex].selectedAnswerChoiceId = answerId
        
        let insecptionResponse = InspectionResponse(inspection: inspection)
        
        do {
            let jsonData = try JSONEncoder().encode(insecptionResponse)
            if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("inspection.json") {
                print("JSON data saved locally: \(fileURL)")
                try jsonData.write(to: fileURL)
                print("JSON data updated and saved successfully.")
            }
        } catch {
            print("Error encoding JSON data: \(error)")
        }
    }
    
    static func removeJSONFile() {
        let fileManager = FileManager.default
        do {
            // Get the URL for the documents directory
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            // Append the file name to the documents URL
            let fileURL = documentsURL.appendingPathComponent("inspection.json")
            
            // Check if the file exists
            if fileManager.fileExists(atPath: fileURL.path) {
                // Attempt to remove the file
                try fileManager.removeItem(at: fileURL)
                print("File removed successfully.")
            } else {
                print("File not found.")
            }
        } catch {
            print("Error removing file: \(error)")
        }
    }
}



