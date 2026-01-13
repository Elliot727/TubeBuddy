import SwiftUI

struct LineFilterChipsView: View {
    @Binding var selectedLine: TubeLine?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        OverflowLayout {
            ForEach(TubeLine.allCases.sorted(by: {$0.string < $1.string})) { line in
                Button(action:{
                    if selectedLine == line {
                        selectedLine = nil
                    }
                    else {
                        selectedLine = line
                    }
                    dismiss()
                }, label :{
                    TubeLineChip(line: line, isSelected: selectedLine == line)
                })
            }
        }
    }
}
