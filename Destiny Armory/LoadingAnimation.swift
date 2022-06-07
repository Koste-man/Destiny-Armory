import SwiftUI

struct LoadingAnimation: View {
    @State var isRotating = false
    
    var body: some View {
        ZStack{
            Color(.clear)
                .ignoresSafeArea()
            
            Circle()
                .trim(from: 0.33, to: 1.0)
                .stroke(Color.gray ,style: StrokeStyle(lineWidth: 10))
                .frame(width: 100, height: 100)
                .rotationEffect(Angle.degrees(isRotating ? 300 : 0))
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: UUID())
            
            Circle()
                .trim(from: 0.33, to: 1.0)
                .stroke(Color.black ,style: StrokeStyle(lineWidth: 10))
                .frame(width: 70, height: 70)
                .rotationEffect(Angle.degrees(isRotating ? -300 : 0))
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: UUID())
        }
        .background(.ultraThinMaterial)
        .onAppear {
            isRotating = true
        }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
