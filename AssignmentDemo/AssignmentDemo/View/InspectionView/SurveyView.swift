

import SwiftUI

struct SurveyView: View {
    
    private let category: Categories
    
    init (with category: Categories) {
        self.category = category
    }
    var body: some View {
        ScrollView {
            ForEach(category.questionList, id: \.id) { question in
                VStack(alignment: .leading) {
                    QuestionView(with: question, category: category)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        
        
        
        
        
    }
}

//struct SurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyView(with: [])
//    }
//}
