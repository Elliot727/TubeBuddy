import NativeKit
import SwiftUI

struct StationCard: View {
    let station: Station
    
    var body: some View {
        NativeStack(type: .v, alignmentV: .leading) {
            
            NativeStack(type: .v, alignmentV: .leading) {
                Text(station.displayName.uppercased())
                    .font(.title2.weight(.black))
                    .foregroundStyle(.primary)
                    .tracking(-0.5)
                
                OverflowLayout {
                    
                    ForEach(station.modes, id: \.self) { mode in
                        Text(mode.uppercased().replacingOccurrences(of: "-", with: " "))
                            .font(.caption2.weight(.black))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.black)
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            
            if !station.lines.isEmpty {
                NativeStack(type: .v, spacing: .none) {
                    ForEach(station.lines.prefix(3).sorted(by: {$0.name < $1.name})) { line in
                        let tubeline = TubeLine(rawValue: line.id)
                        NativeStack(type: .h, spacing: .none) {
                            Rectangle()
                                .fill(tubeline?.color ?? .gray)
                                .frame(width: 16)
                            
                            Text(line.name.uppercased())
                                .font(.footnote.weight(.bold))
                                .foregroundStyle(.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                        }
                    }
                    
                    if station.lines.count > 3 {
                        
                        Text("+\(station.lines.count - 3) MORE")
                            .font(.footnote.weight(.bold))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                        
                    }
                }
            }
        }
        .background(.white)
        .overlay {
            Rectangle()
                .stroke(.black, lineWidth: 4)
        }
        .contentShape(Rectangle())
    }
}
