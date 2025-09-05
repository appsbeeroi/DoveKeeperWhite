import SwiftUI
import SwipeActions

struct PigeonCellView: View {
    
    let pigeon: Pigeon
    let action: () -> Void
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            Button {
                action()
            } label: {
                VStack(spacing: 8) {
                    if let image = pigeon.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .overlay(alignment: .topTrailing) {
                                Text("\(pigeon.status?.icon ?? "") \(pigeon.status?.title ?? "")")
                                    .font(.quicksand(size: 18, .bold))
                                    .foregroundStyle(.baseSecondBlack)
                                    .padding(10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.top, 10)
                                    .padding(.trailing, 15)
                            }
                    }
                    
                    Text(pigeon.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.quicksand(size: 25, .bold))
                        .foregroundStyle(.baseSecondBlack)
                }
                .padding(10)
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

#Preview {
    PigeonCellView(pigeon: Pigeon(isReal: false)) {} editAction: {} removeAction: {}
}

