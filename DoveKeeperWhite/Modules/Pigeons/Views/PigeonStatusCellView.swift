import SwiftUI

struct PigeonStatusCellView: View {
    
    let status: PigeonStatus
    
    @Binding var selectedStatus: PigeonStatus?
    
    var body: some View {
        Button {
            selectedStatus = status
        } label: {
            Text("\(status.icon) \(status.title)")
                .frame(height: 40)
                .padding(.horizontal, 10)
                .font(.quicksand(size: 18, .bold))
                .foregroundStyle(.baseSecondBlack)
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    if selectedStatus == status {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.baseYellow, lineWidth: 3)
                    }
                }
        }
    }
}
