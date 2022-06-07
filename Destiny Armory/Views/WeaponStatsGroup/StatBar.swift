import SwiftUI

struct StatBar: View {
    let rectangleWidth = Int(UIScreen.main.bounds.width / 2)
    
    let statValue: Int
    
    let defaultValue: Int
    
    func statValueString(statValue: Int, defaultValue: Int) -> String{
        if statValue == defaultValue{
            return "\(statValue)"
        } else if statValue > defaultValue{
            return "\(defaultValue) + \(statValue - defaultValue)"
        } else {
            return "\(defaultValue) - \(defaultValue - statValue)"
        }
    }
    
    func redBarValue(statValue: Int, defaultValue: Int) -> Int{
        switch statValue < defaultValue {
        case true:
            return statValue
        case false:
            return defaultValue
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle().frame(width: CGFloat(rectangleWidth), height: 16)
                .foregroundColor(Color(UIColor.systemTeal))
            
            Rectangle().frame(width: CGFloat(rectangleWidth * statValue / 100), height: 16)
                .foregroundColor(Color.yellow)
                .animation(.default, value: UUID())
            
            Rectangle().frame(width: CGFloat(rectangleWidth * redBarValue(statValue: statValue, defaultValue: defaultValue) / 100), height: 16)
                .foregroundColor(Color.red)
                .animation(.default, value: UUID())
            
            Text(statValueString(statValue: statValue, defaultValue: defaultValue))
                .padding([.top, .leading, .bottom], 2.0)
        }
    }
}

//struct StatBar_Previews: PreviewProvider {
//    static var previews: some View {
//        StatBar(statValue: 12, defaultValue: 15)
//    }
//}
