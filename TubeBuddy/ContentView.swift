import NativeKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        BackgroundStack {
            NativeStack(type: .v) {
                NativeStack(type: .h) {
                    Text(Date().mediumDateString)
                        .nativeFont(.button)
                    Spacer()
                    Text("Delays")
                }
                LazyScrollStack {
                    
                }
            }
            .padding([.top, .horizontal])
        }
    }
}

#Preview {
    ContentView()
}
