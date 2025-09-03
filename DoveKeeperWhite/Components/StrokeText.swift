import SwiftUI

struct StrokeText: View {
    
    let text: String
    let fontSize: CGFloat
    let fontWeight: QuicksandFontWeight
    let mainColor: Color?
    let backColor: Color?
    
    init(
        _ text: String,
        fontSize: CGFloat,
        fontWeight: QuicksandFontWeight = .bold,
        mainColor: Color? = nil,
        backColor: Color? = nil
    ) {
        self.text = text
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.mainColor = mainColor
        self.backColor = backColor
    }
    
    var body: some View {
        ZStack {
            Group {
                Text(text).offset(x: -2, y: -2)
                Text(text).offset(x: 0, y: -2)
                Text(text).offset(x: 2, y: -2)
                Text(text).offset(x: -2, y: 0)
                Text(text).offset(x: 2, y: 0)
                Text(text).offset(x: -2, y: 2)
                Text(text).offset(x: 0, y: 2)
                Text(text).offset(x: 2, y: 2)
            }
            .font(.quicksand(size: fontSize, fontWeight))
            .foregroundStyle(backColor ?? .baseBrown)
            
            Text(text)
                .font(.quicksand(size: fontSize, fontWeight))
                .foregroundStyle(mainColor ?? .baseDarkRed)
        }
    }
}
