import NativeKit
import SwiftUI

struct LineStatusView: View {
    let viewModel: LineStatusViewModel

    var body: some View {
        BackgroundStack {
            LoadableView(
                state: viewModel.state,
                isEmpty: { $0.isEmpty },
                content: { lines in
                    NativeStack(type: .v) {
                        ForEach(lines) { line in
                            LineStatusCard(line: line)
                        }
                    }
                },
                empty: {
                    ContentUnavailableView(
                        "No line status available",
                        systemImage: "exclamationmark.triangle",
                        description: Text("Please try again later")
                    )
                }
            )
            .padding([.top, .horizontal])
        }
    }
}
