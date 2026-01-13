import SwiftUI

struct TabBar: View {
    private let container = AppContainer()

    var body: some View {
        TabView {
            Tab("Status", systemImage: "exclamationmark.circle") {
                LineStatusView(viewModel: LineStatusViewModel(repository: container.lineRepository))
            }
            
            Tab("Stations", systemImage: "tram.fill") {
                LineStationsView(viewModel: LineStationsViewModel(repository: container.stationRepository, scope: .all), arrivalsViewModel: ArrivalsViewModel(repository: container.arrivalsRepository))
            }
        }
    }
}

#Preview {
    TabBar()
}
