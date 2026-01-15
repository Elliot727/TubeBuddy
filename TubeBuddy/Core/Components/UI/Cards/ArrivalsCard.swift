import NativeKit
import SwiftUI

struct ArrivalCard: View {
    let arrival: Arrival
    
    private var tubeLine: TubeLine? {
        TubeLine(rawValue: arrival.lineId)
    }
    
    var body: some View {
        NativeStack(type: .v, spacing: .none, alignmentV: .leading) {
            
            if let tubeLine {
                Text(tubeLine.string.uppercased())
                    .font(.caption2.weight(.black))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(tubeLine.color)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            NativeStack(type: .h, spacing: .none) {
                Rectangle()
                    .fill(tubeLine?.color ?? .gray)
                    .frame(width: 8)
                
                NativeStack(type: .v, spacing: .compact, alignmentV: .leading) {
                    Text(arrival.displayTowards)
                        .font(.caption.weight(.black))
                        .foregroundStyle(.black)
                    
                    Text("IN \(arrival.timeToStation / 60) MIN")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

        }
        .background(.white)
        .overlay {
            Rectangle()
                .stroke(tubeLine?.color ?? .black, lineWidth: 4)
        }
    }
}
