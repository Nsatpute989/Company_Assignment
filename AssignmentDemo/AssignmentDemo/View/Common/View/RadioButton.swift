
import SwiftUI

struct RadioButton: View {
    var label: String
    var isSelected: Bool
    var callback: (Bool) -> ()

    var body: some View {
        Button(action: {
            callback(!isSelected)
        }) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(label)
                    .foregroundColor(.black)
            }
        }
        .foregroundColor(.primary)
        .padding(.vertical, 8)
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(label: "Option1", isSelected: false) { value in
            
        }
    }
}
