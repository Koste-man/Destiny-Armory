import SwiftUI

struct IconImage: View {
    
    let icon: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: "https://www.bungie.net" + icon),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 50, maxHeight: 50)
                    .cornerRadius(10)
            },
            placeholder: {
                if icon != ""{
                    ProgressView()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 50, maxHeight: 50)
                }
            }
        )
            .background(Color.gray.opacity(0.2))
    }
}
//
//struct IconImage_Previews: PreviewProvider {
//    static var previews: some View {
//        IconImage(icon: "/common/destiny2_content/icons/e994975f4fae7a9a4e0d27e5173dece3.png")
//    }
//}
