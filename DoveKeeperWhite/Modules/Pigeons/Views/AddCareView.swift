import SwiftUI

struct AddCareView: View {
    
    @State var care: Care
    
    let saveAction: (Care) -> Void
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 8) {
                navigation
                datePicker
                
                notes
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
            .padding(.horizontal, 35)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Text("Add care")
                .frame(maxWidth: .infinity)
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            Button {
                saveAction(care)
            } label: {
                Image(care.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
            .disabled(!care.isUnlock)
        }
    }
    
    private var datePicker: some View {
        DatePicker("", selection: $care.date, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.wheel)
            .padding()
            .background(.white)
            .cornerRadius(18)
    }
    
    private var notes: some View {
        VStack(spacing: 12) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 15, .bold))
                .foregroundStyle(.baseGray)
            
            BaseTextField(text: $care.notes, isFocused: $isFocused)
        }
    }
}

#Preview {
    AddCareView(care: Care(isReal: false)) { _ in }
}
