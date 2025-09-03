import SwiftUI

struct SettingsCellView: View {
    
    let type: SettingsCellType
    
    @Binding var isNotificationEnable: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button {
            guard type != .notifications else { return }
            action()
        } label: {
            HStack {
                Text(type.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 20, .bold))
                    .foregroundStyle(.black)
                
                if type == .notifications {
                    Toggle(isOn: $isNotificationEnable) {}
                        .labelsHidden()
                        .tint(.baseYellow)
                } else {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.baseSecondBlack)
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 12)
            .background(.white)
            .cornerRadius(18)
        }
    }
}
