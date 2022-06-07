import SwiftUI

struct WeaponListItem: View {
    
    let weapon: WeaponModel.Weapon
    
    init(weapon: WeaponModel.Weapon) {
        self.weapon = weapon
    }
    
    var body: some View {
        
        ZStack{
            Color.gray.opacity(0.5).cornerRadius(10)
            
            HStack{
                ZStack{
                    AsyncImage(
                        url: URL(string: "https://www.bungie.net" + "\(weapon.icon)"),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        }
                    )
                    
                    AsyncImage(
                        url: URL(string: "https://www.bungie.net" + "\(weapon.iconWatermark ?? "")"),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            Color(.clear)
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        }
                    )
                }
                .cornerRadius(10)
                
                Spacer()
                
                Text(weapon.name)
                    .padding()
                    .font(Font.custom("Futura-Medium", fixedSize: 15))
            }
        }
        .frame(height: 100)
        .foregroundColor(Color.white)
    }
}

//struct WeaponListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        WeaponListItem(weapon: previewWeapon)
//    }
//}
