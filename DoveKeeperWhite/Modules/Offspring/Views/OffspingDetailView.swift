import SwiftUI

struct OffspingDetailView: View {
    
    @EnvironmentObject var viewModel: OffspingViewModel
    
    let pigeon: Pigeon
    
    @State private var isShowRemoveAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 8) {
                navigation
                content
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
        }
        .navigationBarBackButtonHidden()
        .alert("Are you sure you want to delete this pigeon?", isPresented: $isShowRemoveAlert) {
            Button("Remove", role: .destructive) {
                viewModel.remove(pigeon)
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Spacer()
            
            HStack(spacing: 8) {
                Button {
                    viewModel.save(pigeon)
                } label: {
                    Image(.Images.Buttons.complete)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .cornerRadius(10)
                }
            }
            
            Button {
                isShowRemoveAlert.toggle()
            } label: {
                Image(systemName: "trash")
                    .frame(width: 44, height: 44)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.red)
                    .background(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                image
                
                VStack(spacing: 10) {
                    birdInfo
                    parents
                }
                .padding(.horizontal, 35)
            }
        }
    }
    
    private var image: some View {
        Image(uiImage: pigeon.image ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(height: 270)
            .frame(maxWidth: .infinity)
            .clipped()
            .cornerRadius(25)
            .overlay(alignment: .topLeading) {
                Text("\(pigeon.status?.icon ?? "") \(pigeon.status?.title ?? "")")
                    .font(.quicksand(size: 18, .bold))
                    .foregroundStyle(.baseSecondBlack)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.top, 18)
                    .padding(.leading, 35)
            }
    }
    
    private var birdInfo: some View {
        VStack(spacing: 7) {
            Text(pigeon.name)
                .frame(height: 54)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 35, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            HStack {
                Text("Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 16, .bold))
                    .foregroundStyle(.baseGray)
                
                let date = pigeon.birthDate ?? Date()
                
                Text(date.formatted(.dateTime.year().month(.twoDigits).day()))
                    .font(.quicksand(size: 18, .bold))
                    .foregroundStyle(.baseSecondBlack)
            }
            
            VStack(spacing: 8) {
                Text("Chick count")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 16, .bold))
                    .foregroundStyle(.baseGray)
                
                Text("\(pigeon.chickCount) birds")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 18, .bold))
                    .foregroundStyle(.baseSecondBlack)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    private var parents: some View {
        VStack(spacing: 8) {
            Text("Parents")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            ForEach(pigeon.parent) { pigeon in
                OffspingParentListCellView(pigeon: pigeon, isSelectable: false, parents: .constant([]))
            }
        }
    }
}
