

import SwiftUI

struct AuthenticationView: View {
    
    @StateObject var authViewModel = AuthenticationViewModel()
    
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack {
            Text(AppConstants.welcome)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 42)
            
            if !authViewModel.registrationFailedResult.isEmpty {
                Text(authViewModel.registrationFailedResult)
                    .foregroundColor(Color.red)
                    .font(.subheadline)
                    .padding(.bottom, 42)
            }
            
            TextField(AppConstants.enterEmail, text: $emailText)     // no placeholder text and passing data
                .padding(.horizontal, 10)  // add some extra padding left and right
                .frame(height: 42)
                .border(.black, width: 1.0)
            TextField(AppConstants.enterPassword, text: $passwordText)     // no placeholder text and passing data
                .padding(.horizontal, 10)  // add some extra padding left and right
                .frame(height: 42)
                .border(.black, width: 1.0)
            
            HStack {
                Button(action: {
                    authViewModel.doAuthenticate(user: AuthModel(email: emailText, password: passwordText), type: .login)
                }) {
                    Text(AppConstants.signIn)
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                }
                
                Button(action: {
                    authViewModel.doAuthenticate(user: AuthModel(email: emailText, password: passwordText), type: .register)
                }) {
                    Text(AppConstants.register)
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                }
            }
        }
        .padding()
        .onReceive(authViewModel.$loggedInStatus, perform: { value in
            if value {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        })
        .background(NavigationLink(
            destination: InspectionView(),
            isActive: $isLoggedIn,
            label: { EmptyView() }
        ))
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
