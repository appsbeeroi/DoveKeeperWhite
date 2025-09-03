import SwiftUI

struct PigeonBreedDetail: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var pigeon: PigeonBreed
    
    let likeAction: (PigeonBreed) -> Void
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 10) {
                navigation
                
                ScrollView(showsIndicators: false) {
                    image
                    
                    VStack(spacing: 10) {
                        title
                        description
                        features
                    }
                    .padding(.horizontal, 35)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.baseYellow)
            }
            
            Spacer()
            
            Button {
                pigeon.isFavorite.toggle()
                likeAction(pigeon)
            } label: {
                Image(pigeon.isFavorite ? .Images.Buttons.like : .Images.Buttons.unlike)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Image(pigeon.img)
            .resizable()
            .scaledToFill()
            .frame(height: 270)
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            .clipped()
            .cornerRadius(25)
    }
    
    private var title: some View {
        Text(pigeon.name)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.quicksand(size: 35, .bold))
            .foregroundStyle(.baseSecondBlack)
    }
    
    private var description: some View {
        VStack(spacing: 12) {
            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 16, .bold))
                .foregroundStyle(.baseGray)
            
            Text(pigeon.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 18, .bold))
                .foregroundStyle(.baseSecondBlack)
        }
    }
    
    private var features: some View {
        VStack(spacing: 12) {
            Text("Features")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 16, .bold))
                .foregroundStyle(.baseGray)
            
            VStack {
                ForEach(pigeon.features, id: \.self) { text in
                    HStack {
                        VStack {
                            Text("•")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.baseSecondBlack)
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        
                        Text(text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.quicksand(size: 18, .bold))
                            .foregroundStyle(.baseSecondBlack)
                    }
                }
            }
        }
    }
}

#Preview {
    PigeonBreedDetail(pigeon: PigeonBreed()) { _ in }
}
