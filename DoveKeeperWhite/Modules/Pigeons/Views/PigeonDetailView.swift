import SwiftUI

struct PigeonDetailView: View {
    
    @ObservedObject var viewModel: PigeonsViewModel
    
    @State var pigeon: Pigeon
    
    @State private var showingCareState: CareType?
    @State private var careToEdit: Care?
    
    @State private var isShowAddCareView = false
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
        .navigationDestination(isPresented: $isShowAddCareView) {
            AddCareTypeView(care: careToEdit ?? Care(isReal: true)) { care in
                if let index = pigeon.cares.firstIndex(where: { $0.id == care.id }) {
                    pigeon.cares[index] = care
                } else {
                    pigeon.cares.append(care)
                }
                
                isShowAddCareView = false 
            }
        }
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
                birdInfo
                cares
            }
        }
        .animation(.easeInOut, value: showingCareState)
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
                Text("Age")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 16, .bold))
                    .foregroundStyle(.baseGray)
                
                Text("\(pigeon.age) years")
                    .font(.quicksand(size: 18, .bold))
                    .foregroundStyle(.baseSecondBlack)
            }
            
            VStack(spacing: 8) {
                Text("Notes")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 16, .bold))
                    .foregroundStyle(.baseGray)
                
                Text(pigeon.notes)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.quicksand(size: 18, .bold))
                    .foregroundStyle(.baseSecondBlack)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var cares: some View {
        VStack(spacing: 12) {
            Text("Cares diary")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.quicksand(size: 25, .bold))
                .foregroundStyle(.baseSecondBlack)
            
            VStack(spacing: 10) {
                if pigeon.cares.isEmpty {
                    Text("There’s nothing here yet")
                        .font(.quicksand(size: 17, .bold))
                        .foregroundStyle(.baseSecondBlack)
                } else {
                    HStack(spacing: 5) {
                        ForEach(CareType.allCases) { type in
                            Button {
                                showingCareState = showingCareState == type ? nil : type
                            } label: {
                                Text("\(type.icon) \(type.title)")
                                    .frame(height: 40)
                                    .padding(.horizontal, 10)
                                    .font(.quicksand(size: 14, .bold))
                                    .foregroundStyle(.baseSecondBlack)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .lineLimit(1)
                                    .overlay {
                                        if showingCareState == type {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.yellow, lineWidth: 3)
                                        }
                                    }
                            }
                        }
                    }
                    .minimumScaleFactor(0.8)
                }
                
                let filteredCares = pigeon.cares.filter { showingCareState == nil ? true : $0.type == showingCareState }
                
                ForEach(filteredCares) { care in
                    CareCellView(care: care) {
                        //
                    } removeAction: {
                        guard let index = pigeon.cares.firstIndex(where: { $0.id == care.id }) else { return }
                        pigeon.cares.remove(at: index)
                    }
                }
                
                addButton
            }
        }
        .padding(.top, 14)
        .padding(.horizontal, 35)
    }
    
    private var addButton: some View {
        Button {
            isShowAddCareView.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
                .overlay {
                    Image(systemName: "plus")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.baseYellow)
                }
        }
    }
}


#Preview {
    PigeonDetailView(viewModel: PigeonsViewModel(), pigeon: Pigeon(isReal: false))
}


