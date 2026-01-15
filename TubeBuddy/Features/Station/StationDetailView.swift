import NativeKit
import SwiftUI

struct StationDetailView: View {
    let station: Station
    let viewModel: ArrivalsViewModel
    @State private var selectedLine: SelectedLine?
    
    var body: some View {
        BackgroundStack {
            NativeStack(type: .v, alignmentV: .leading) {
                
                NativeStack(type: .v, spacing: .compact, alignmentV: .leading) {
                    Text(station.displayName.uppercased())
                        .font(.largeTitle.weight(.black))
                        .tracking(-0.5)
                        .foregroundStyle(.black)
                    
                    NativeStack(type: .h, spacing: .compact) {
                        ForEach(station.modes, id: \.self) { mode in
                            Text(mode.uppercased().replacingOccurrences(of: "-", with: " "))
                                .font(.caption2.weight(.black))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.black)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .overlay {
                    Rectangle()
                        .stroke(.black, lineWidth: 4)
                }
                
                if !station.lines.isEmpty {
                    LazyScrollStack {
                        NativeStack(type: .v, spacing: .none) {
                            ForEach(station.lines, id: \.id) { line in
                                let tubeLine = TubeLine(rawValue: line.id)
                                
                                Button {
                                    selectedLine = SelectedLine(id: line.id)
                                } label: {
                                    NativeStack(type: .h, spacing: .none) {
                                        Rectangle()
                                            .fill(tubeLine?.color ?? .gray)
                                            .frame(width: 16)
                                        
                                        NativeStack(type: .v, spacing: .compact, alignmentV: .leading) {
                                            Text(line.name.uppercased())
                                                .font(.headline.weight(.black))
                                                .foregroundStyle(.black)
                                            
                                            Text("VIEW STATUS")
                                                .font(.caption.weight(.bold))
                                                .foregroundStyle(.gray)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .overlay {
                                        Rectangle()
                                            .stroke(.black, lineWidth: 2)
                                    }
                                }
                                .buttonStyle(.plain)

                            }
                        }
                    }
                }
            }
            .padding([.top, .horizontal])
            .task {
                await viewModel.load(for: station.naptanId)
            }
            .sheet(item: $selectedLine) { line in
                ArrivalsView(line: line, viewModel: viewModel)
            }

        }
    }
}

struct SelectedLine: Identifiable {
    let id: String
}
