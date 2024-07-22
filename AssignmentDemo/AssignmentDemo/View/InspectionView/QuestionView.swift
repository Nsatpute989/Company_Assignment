

import SwiftUI

struct QuestionView: View {
    
    let question: Questions
    let category: Categories
    @State private var selectedOption: Int?
    
    init(with question: Questions, category: Categories) {
        self.question = question
        self.category = category
        selectedOption = question.selectedAnswerChoiceId
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.questionTitle)
                .font(.title3)
                .fontWeight(.black)
                .padding(.bottom, 20)
            
            ForEach(question.answers, id: \.id) { answer in
                RadioButton(
                    label: answer.answerLabel,
                    isSelected: answer.id == selectedOption,
                    callback: { selected in
                        if selected {
                            PersistentFileManager.modifyData(question: question, answerId: answer.id, category: category)
                            selectedOption = answer.id
                               
                        }
                    }
                )
            }
        }
        .padding()
        .onAppear {
            selectedOption = question.selectedAnswerChoiceId
        }
    }
}

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(with: Questions(answerChoices: nil, id: nil, name: nil, selectedAnswerChoiceId: nil), category: <#Categories#>)
//    }
//}
