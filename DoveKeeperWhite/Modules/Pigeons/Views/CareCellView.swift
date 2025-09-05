import SwiftUI
import SwipeActions

struct CareCellView: View {
    
    let care: Care
    
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            HStack {
                VStack(spacing: 12) {
                    Text(care.date.formatted(.dateTime.year().month(.twoDigits).day()))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.quicksand(size: 12, .bold))
                        .foregroundStyle(.baseGray)
                    
                    Text(care.notes)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.quicksand(size: 18, .bold))
                        .foregroundStyle(.baseSecondBlack)
                        .multilineTextAlignment(.leading)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .background(.white)
                .cornerRadius(15)
            }
        } trailingActions: { context in
            HStack(spacing: 4) {
                Button {
                    context.state.wrappedValue = .closed
                    editAction()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 42, height: 42)
                        .foregroundStyle(.white)
                        .overlay {
                            Image(systemName: "pencil.line")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(.blue)
                        }
                }
                
                Button {
                    context.state.wrappedValue = .closed
                    removeAction()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 42, height: 42)
                        .foregroundStyle(.white)
                        .overlay {
                            Image(systemName: "trash")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(.red)
                        }
                }
            }
        }
        .swipeMinimumDistance(30)
    }
}
