import SwiftUI

struct AddOffspingView: View {
    
    @State var pigeon: Pigeon
    
    @State private var birtDate = Date()
    @State private var isShowImagePicker = false
    @State private var isShowParentListView = false
    
    @FocusState private var isFocused: Bool
    
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
        .navigationDestination(isPresented: $isShowParentListView) {
            OffspingParentsListView(pigeon: pigeon)
        }
        .onAppear {
            pigeon.status = .young
        }
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $pigeon.image)
        }
        .onChange(of: birtDate) { date in
            pigeon.birthDate = date
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Text("Add offsping")
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
                .padding(.horizontal, 35)
            
            Button {
                isShowParentListView = true
            } label: {
                Image(pigeon.image != nil && pigeon.birthDate != nil && pigeon.name != "" ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
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
                name
                datePicker
                chickSection
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
    
    private var datePicker: some View {
        VStack(spacing: 2) {
            Text("Birth date")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseGray)
            
            DatePicker("", selection: $birtDate,  in: ...Date(), displayedComponents: [.date])
                .labelsHidden()
                .datePickerStyle(.wheel)
        }
        .padding()
        .background(.white)
        .cornerRadius(18)
    }
    
    private var name: some View {
        VStack(spacing: 2) {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseGray)
            
            BaseTextField(text: $pigeon.name, isFocused: $isFocused)
        }
    }
    
    private var chickSection: some View {
        VStack(spacing: 2) {
            Text("Chick count")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseGray)
            
            BaseTextField(text: $pigeon.chickCount, keyboard: .numberPad, isFocused: $isFocused)
        }
    }
}

#Preview {
    AddOffspingView(pigeon: Pigeon(isReal: false))
}

