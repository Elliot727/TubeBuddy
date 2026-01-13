import NativeKit
import SwiftUI

struct LineStationsView: View {
    @State private var selectedLine: TubeLine?
    @State private var searchText: String = ""
    @State private var showLineSelectionSheet: Bool = false
    let viewModel: LineStationsViewModel
    let arrivalsViewModel: ArrivalsViewModel

    var body: some View {
        NavigationStack {
            BackgroundStack {
                NativeStack(type: .v) {
                    NativeStack(type: .h) {
                        InputField(text: $searchText, placeholder: "Search for a station")
                        Button(action: {
                            showLineSelectionSheet.toggle()
                        }, label: {
                            NativeIcon("line.3.horizontal.decrease", color: .text)
                        })
                        .padding(.horizontal, 16)
                    }
                    LoadableView(
                        state: viewModel.state,
                        isEmpty: { filteredStations(from: $0).isEmpty },
                        content: { stations in
                            ForEach(filteredStations(from: stations), id:\.id) { station in
                                NavigationLink {
                                    StationDetailView(station: station, viewModel: arrivalsViewModel)
                                } label: {
                                    StationCard(station: station)
                                }
                                .buttonStyle(.plain)
                            }
                        },
                        empty: {
                            ContentUnavailableView(
                                "No stations found",
                                systemImage: "magnifyingglass",
                                description: Text("Try a different search")
                            )
                        }
                    )
                    .task {
                        if case .idle = viewModel.state {
                            await viewModel.load()
                        }
                    }
                    .onChange(of: selectedLine) { _, line in
                        viewModel.setScope(
                            line.map { .line(id: $0.id) } ?? .all
                        )
                    }
                    .sheet(isPresented: $showLineSelectionSheet) {
                        LineFilterChipsView(selectedLine: $selectedLine)
                            .presentationDetents([.fraction(0.25)])
                    }
                    .presentationDetents([.medium])
                }
                .padding([.top, .horizontal])
            }
        }
    }
    
    func filteredStations(from stations: [Station]) -> [Station] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter {
            $0.displayName.localizedCaseInsensitiveContains(searchText)
        }
    }
}
