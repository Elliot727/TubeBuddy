import NativeKit
import SwiftUI

struct InputField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.body.weight(.bold))
            .foregroundStyle(.black)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .overlay {
                Rectangle()
                    .stroke(.black, lineWidth: 4)
            }
    }
}


