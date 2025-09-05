import SwiftUI

struct AddPigeonView: View {
    
    @ObservedObject var viewModel: PigeonsViewModel
    
    @State var pigeon: Pigeon
    
    @State private var isShowImagePicker = false
    @State private var isShowDetailView = false
    
    @FocusState var isFocused: Bool
    
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
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
         }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $pigeon.image)
        }
        .navigationDestination(isPresented: $isShowDetailView) {
            PigeonDetailView(viewModel: viewModel, pigeon: pigeon)
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Text("Add pigeon")
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
                .padding(.horizontal, 35)
            
            Button {
                isShowDetailView = true
            } label: {
                Image(pigeon.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
        }
    }
    
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                image
                nameInput
                ageInput
                statusSection
                notesInput
            }
            .padding(.top, 24)
            .padding(.horizontal, 35)
        }
    }
    
    private var image: some View {
        Button {
            isShowImagePicker.toggle()
        } label: {
            if let image = pigeon.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 123, height: 123)
                    .clipped()
                    .cornerRadius(16)
                    .overlay {
                        Image(systemName: "photo.artframe")
                            .font(.system(size: 50, weight: .medium))
                            .foregroundStyle(.baseGray.opacity(0.3))
                    }
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 123, height: 123)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(systemName: "photo.artframe")
                            .font(.system(size: 50, weight: .medium))
                            .foregroundStyle(.baseGray.opacity(0.3))
                    }
            }
        }
    }
    
    private var nameInput: some View {
        VStack(spacing: 2) {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseLightGray)
            
            BaseTextField(text: $pigeon.name, isFocused: $isFocused)
        }
    }
    
    private var ageInput: some View {
        VStack(spacing: 2) {
            Text("Age")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseLightGray)
            
            BaseTextField(text: $pigeon.age, keyboard: .numberPad, isFocused: $isFocused)
        }
    }
    
    private var statusSection: some View {
        VStack(spacing: 2) {
            Text("Status")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseLightGray)
            
            HStack(spacing: 6) {
                ForEach(PigeonStatus.allCases) { status in
                    PigeonStatusCellView(status: status, selectedStatus: $pigeon.status)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var notesInput: some View {
        VStack(spacing: 2) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseLightGray)
            
            AdaptableTextField(text: $pigeon.notes, isFocused: $isFocused)
        }
    }
}

#Preview {
    AddPigeonView(viewModel: PigeonsViewModel(), pigeon: Pigeon(isReal: false))
}
