import SwiftUI

struct LazyScrollStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                content
                    .padding(2)
            }
            
        }
        .scrollIndicators(.hidden)
    }
}
