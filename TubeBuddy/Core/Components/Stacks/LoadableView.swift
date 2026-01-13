import SwiftUI

struct LoadableView<Value, Content: View, Empty: View>: View {
    let state: LoadState<Value>
    let isEmpty: (Value) -> Bool
    let content: (Value) -> Content
    let empty: () -> Empty

    var body: some View {
        switch state {
        case .idle:
            Color.clear

        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let value):
            if isEmpty(value) {
                empty()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                LazyScrollStack {
                    content(value)
                        .padding(2)
                }
            }

        case .failed(let error):
            Spacer()
            VStack {
                Text("Something went wrong")
                Text(error.localizedDescription)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            Spacer()
        }
        
    }
}
