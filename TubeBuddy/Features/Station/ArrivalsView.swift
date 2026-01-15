import NativeKit
import SwiftUI

struct ArrivalsView: View {
    let line: SelectedLine
    let viewModel: ArrivalsViewModel
    var body: some View {
        NativeStack(type: .v) {
            BackButton()
                .frame(maxWidth: .infinity, alignment: .leading)
            LoadableView(
                state: viewModel.state,
                isEmpty: { arrivals in
                    arrivals.filter { $0.lineId == line.id }.isEmpty
                },
                content: { arrivals in
                    LazyScrollStack {
                        ForEach(Array(arrivals.filter({$0.lineId == line.id}).sorted(by: { $0.timeToStation < $1.timeToStation })).enumerated(), id: \.element.compositeId) { index, arrival in
                            ArrivalCard(arrival: arrival)
                        }
                    }
          
                },
                empty: {
                    ContentUnavailableView(
                        "No arrivals found",
                        systemImage: "magnifyingglass",
                        description: Text("Try a different line")
                    )
                }
            )
        }
        .padding([.top, .horizontal])
    }
}
