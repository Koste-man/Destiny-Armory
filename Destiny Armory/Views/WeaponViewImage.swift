import SwiftUI

struct WeaponViewImage: View {
    
    let weapon: WeaponModel.Weapon
    
    var body: some View {
        ZStack{
            AsyncImage(
                url: URL(string: "https://www.bungie.net" + "\(weapon.screenshot)"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width - 10, maxHeight: 200)
                        .cornerRadius(30)
                },
                placeholder: {
                    ProgressView()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width - 10, maxHeight: 200)
                        .frame(width: 200, height: 200)
                }
            )
            
            HStack{
                Text(weaponDamageType(defaultDamageType: weapon.elementClass))
                
                Spacer()
                
                Text(weapon.weaponType)

            }.offset(y: 70)
                .padding()
        }
        .padding()
        .shadow(color: Color.black, radius: 5)
    }
    
    private func weaponDamageType(defaultDamageType: Int) -> String{
        switch defaultDamageType {
        case 1: return "kinetic"
        case 2: return "arc"
        case 3: return "solar"
        case 4: return "void"
        case 6: return "stasis"
        default:
            return "error"
        }
    }
}

//struct WeaponViewImage_Previews: PreviewProvider {
//    static var previews: some View {
//        WeaponViewImage(weapon: previewWeapon)
//    }
//}
