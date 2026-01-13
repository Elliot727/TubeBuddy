import NativeKit
import SwiftUI

struct LineStatusCard: View {
    let line: Line
    
    private var statusColor: Color {
        line.severity >= 10 ? .green : line.severity >= 6 ? .orange : .red
    }
    
    var body: some View {
        NativeStack(type: .v, alignmentV: .leading) {
            
            Text(line.statusText.uppercased())
                .font(.caption2.weight(.black))
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(line.lineColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(line.name.uppercased())
                .font(.title2.weight(.black))
                .foregroundStyle(line.lineColor)
                .tracking(-0.5)
            
            if let reason = line.lineStatuses.first?.reason, !reason.isEmpty {
                NativeStack(type: .h, spacing: .none) {
                    Rectangle()
                        .fill(line.lineColor)
                        .frame(width: 4)
                    
                    Text(reason)
                        .font(.caption)
                        .foregroundStyle(.text)
                        .padding(.leading, 12)
                        .padding(.vertical, 4)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .overlay {
            Rectangle()
                .stroke(line.lineColor, lineWidth: 4)
        }
    }
}
