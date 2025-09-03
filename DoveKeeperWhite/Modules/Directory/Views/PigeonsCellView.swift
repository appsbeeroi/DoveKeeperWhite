import SwiftUI

struct PigeonsCellView: View {
    
    let pigeon: PigeonBreed
    let likeAction: () -> Void
    let action: (() -> Void)?
    
    init(
        pigeon: PigeonBreed,
        likeAction: @escaping () -> Void,
        action: (() -> Void)? = nil
    ) {
        self.pigeon = pigeon
        self.likeAction = likeAction
        self.action = action
    }
    
    var body: some View {
        Button {
            if let action {
                action()
            }
        } label: {
            VStack(spacing: 8) {
                Image(pigeon.img)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(18)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            likeAction()
                        } label: {
                            Image(pigeon.isFavorite ? .Images.Buttons.like : .Images.Buttons.unlike)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .padding(10)
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
    }
}

#Preview {
    PigeonsCellView(pigeon: PigeonBreed.allBreeds[0]) {} action: {}
}
