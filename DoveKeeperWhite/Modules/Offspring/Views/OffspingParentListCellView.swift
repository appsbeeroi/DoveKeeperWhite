import SwiftUI

struct OffspingParentListCellView: View {
    
    let pigeon: Pigeon
    let isSelectable: Bool
    let isDisable: Bool
    
    @Binding var parents: [Pigeon]
    
    var body: some View {
        Button {
            guard isSelectable else { return }
            if !parents.contains(where: { $0.id == pigeon.id }) && parents.count <= 2 {
                parents.append(pigeon)
            } else if let index = parents.firstIndex(where: { $0.id == pigeon.id }) {
                parents.remove(at: index)
            }
        } label: {
            HStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack(spacing: 5) {
                        if let image = pigeon.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 55, height: 55)
                                .clipped()
                                .cornerRadius(30)
                        }
                        
                        Text(pigeon.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.quicksand(size: 20, .bold))
                            .foregroundStyle(.baseSecondBlack)
                    }
                    
                    HStack {
                        Text("\(pigeon.status?.icon ?? "") \(pigeon.status?.title ?? "")")
                            .frame(height: 20)
                            .padding(.horizontal, 7)
                            .font(.quicksand(size: 11, .bold))
                            .foregroundStyle(.baseSecondBlack)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.baseYellow, lineWidth: 3)
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if isSelectable {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.yellow, lineWidth: 3)
                        .frame(width: 25, height: 25)
                        .overlay {
                            if parents.contains(where: { $0.id == pigeon.id }) {
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 18, height: 18)
                                    .foregroundStyle(.baseYellow)
                            }
                        }
                }
            }
            .padding(10)
            .background(.white)
            .cornerRadius(18)
            .opacity(parents.count == 2 && !parents.contains(where: { $0.id == pigeon.id }) && isDisable ? 0.6 : 1)
        }
        .disabled(isDisable && parents.count == 2 && !parents.contains(where: { $0.id == pigeon.id }))
    }
}
