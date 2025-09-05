import SwiftUI

struct AddCareTypeView: View {
    
    @State var care: Care
    
    let saveAction: (Care) -> Void
    
    @State private var isShowAddCareView = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .resize()
            
            VStack(spacing: 8) {
                navigation
                careSelection
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 30)
            .padding(.horizontal, 35)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowAddCareView) {
            AddCareView(care: care) { care in
                saveAction(care)
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            BaseBackButton()
            
            Text("Add care")
                .frame(maxWidth: .infinity)
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
                .padding(.horizontal, 35)
            
            Button {
                isShowAddCareView = true
            } label: {
                Image(care.type != nil ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
            .disabled(care.type == nil )
        }
    }
    
    private var careSelection: some View {
        VStack(spacing: 12) {
            ForEach(CareType.allCases) { type in
                Button {
                    care.type = type
                } label: {
                    Text("\(type.icon) \(type.title)")
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .font(.quicksand(size: 25, .bold))
                        .foregroundStyle(.baseSecondBlack)
                        .background(.white)
                        .cornerRadius(18)
                        .overlay {
                            if care.type == type {
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(.baseYellow, lineWidth: 3)
                            }
                        }
                }
            }
        }
        .padding(.top, 40)
    }
}

#Preview {
    AddCareTypeView(care: Care(isReal: false)) { _ in }
}
