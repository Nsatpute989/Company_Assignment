

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            AuthenticationView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

