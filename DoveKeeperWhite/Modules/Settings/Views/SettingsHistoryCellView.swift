import SwiftUI

struct SettingsHistoryCellView: View {
    
    let type: SettingsHistoryType
    let removedType: SettingsHistoryType?
    let isShowClearView: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(type.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 20, .bold))
                    .foregroundStyle(.black)
                
                if let removedType,
                   removedType == type,
                   isShowClearView {
                    Text("Clear")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.red)
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 12)
            .background(.white)
            .cornerRadius(18)
            .animation(.easeInOut, value: isShowClearView)
        }
        .disabled(isShowClearView)
    }
}
