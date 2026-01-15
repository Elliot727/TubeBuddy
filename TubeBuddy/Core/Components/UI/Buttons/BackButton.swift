import NativeKit
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            NativeIcon("arrow.left")
        }

    }
}

#Preview {
    BackButton()
}
