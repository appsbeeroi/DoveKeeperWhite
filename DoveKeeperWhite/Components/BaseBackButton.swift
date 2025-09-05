import SwiftUI

struct BaseBackButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .font(.system(size: 30, weight: .medium))
                .foregroundStyle(.baseYellow)
        }
    }
}
