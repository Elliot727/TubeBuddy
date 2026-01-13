import SwiftUI

struct TubeLineChip: View {
    let line: TubeLine
    let isSelected: Bool
    var body: some View {
        Text(line.string)
            .foregroundStyle(isSelected ? line.textColor : .text)
            .font(.caption)
            .padding(8)
            .background(line.color.opacity(isSelected ? 1 : 0.1), in: Capsule())
            .overlay {
                Capsule()
                    .stroke(line.color, lineWidth: 1)
            }
    }
}
