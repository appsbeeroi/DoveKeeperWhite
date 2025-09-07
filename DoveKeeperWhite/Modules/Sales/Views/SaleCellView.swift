import SwiftUI
import SwipeActions

struct SaleCellView: View {
    
    let sale: Sale
    let action: () -> Void
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            Button {
                action()
            } label: {
                HStack(spacing: 8) {
                    ZStack {
                        ForEach(Array(sale.pigeons.enumerated()), id: \.offset) { (index, pigeon) in
                            if index <= 3,
                               let image = pigeon.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 48, height: 48)
                                    .clipped()
                                    .cornerRadius(35)
                                    .padding(.leading, CGFloat(index) * 20)
                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        Text(sale.date.formatted(.dateTime.year().month(.twoDigits).day()))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.quicksand(size: 12, .bold))
                            .foregroundStyle(.baseGray)
                        
                        Text("\(sale.price) $")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.quicksand(size: 25, .bold))
                            .foregroundStyle(.baseSecondBlack)
                    }
                    
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.black)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 13)
                .background(.white)
                .cornerRadius(18)
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
