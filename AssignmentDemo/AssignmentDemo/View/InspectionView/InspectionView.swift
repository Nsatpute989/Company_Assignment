

import SwiftUI

struct InspectionView: View {
    @StateObject var viewModel = InspectionViewModel()
    @State var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text(AppConstants.area)
                    .font(.title3)
                    .fontWeight(.black)
                Text(viewModel.areaName)
            }
            
            HStack {
                Text(AppConstants.inspectionType)
                    .font(.title3)
                    .fontWeight(.black)
                Text(viewModel.inceptionType)
            }
            
            Text(AppConstants.survey)
                .font(.title2)
                .fontWeight(.black)
            
            List(viewModel.categories, id: \.id) { category in
                NavigationLink(destination: SurveyView(with: category)
                                .environmentObject(viewModel)) {
                    Text(category.categoryName)
                }
               
            }
            .listStyle(.plain)
            
            Spacer()
            
            Button(action: {
                viewModel.submitInspection()
            }) {
                Text(AppConstants.submit)
                    .fontWeight(.heavy)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
            }
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text(viewModel.submitInspectionResult), message: Text(""), dismissButton: .default(Text(AppConstants.okBtn), action: {
                    
                    presentationMode.wrappedValue.dismiss()
                }))
                    }
            
                
        }
        .padding()
        .onAppear {
            viewModel.startInspection()
        }
    
        .onReceive(viewModel.$submitInspectionResult, perform: { value in
            if value.count > 0 {
                showAlert =  true
            }
        })
    }
}

struct InspectionView_Previews: PreviewProvider {
    static var previews: some View {
        InspectionView()
    }
}
