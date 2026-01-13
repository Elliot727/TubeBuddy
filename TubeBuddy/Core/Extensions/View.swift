import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentShape(.rect)
            .padding()
            .background(.card, in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.border)
            )
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardStyle())
    }
}
