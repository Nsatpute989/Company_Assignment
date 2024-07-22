

import Foundation

struct InspectionResponse: Encodable, Decodable {
    var inspection: Inspection?
}
struct Inspection : Codable {
    let area : Area?
    let id : Int?
    let inspectionType : InspectionType?
    var survey : Survey?
}

struct Area : Codable {
    let id : Int?
    let name : String?
}

struct InspectionType : Codable {
    let access : String?
    let id : Int?
    let name : String?
}

struct AnswerChoices : Codable {
    let id : Int?
    let name : String?
    let score : Double?
}

extension AnswerChoices {
    var answerLabel: String {
        name ?? ""
    }
}

struct Questions : Codable {
    let answerChoices : [AnswerChoices]?
    let id : Int?
    let name : String?
    var selectedAnswerChoiceId : Int?
}

extension Questions {
    var questionTitle: String {
        name ?? ""
    }
    
    var answers: [AnswerChoices] {
        answerChoices ?? []
    }
}

struct Categories : Codable {
    let id : Int?
    let name : String?
    var questions : [Questions]?
}
extension Categories {
    var categoryName: String {
        name ?? ""
    }
    
    var questionList: [Questions] {
        questions ?? []
    }
}

struct Survey : Codable {
    var categories : [Categories]?
    let id : Int?
}
