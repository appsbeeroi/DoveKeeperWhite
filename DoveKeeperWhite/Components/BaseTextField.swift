import SwiftUI

struct BaseTextField: View {
        
    @Binding var text: String
    
    let keyboard: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    init(
        text: Binding<String>,
        keyboard: UIKeyboardType = .default,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.keyboard = keyboard
        self._isFocused = isFocused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text("Write here...")
                .foregroundColor(.baseLightGray))
                .font(.quicksand(size: 20, .bold))
                .foregroundStyle(.baseSecondBlack)
                .keyboardType(keyboard)
                .focused($isFocused)
            
            if text != "" {
                Button {
                    text = ""
                    isFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.baseLightGray)
                }
            }
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(20)
    }
}

