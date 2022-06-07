import SwiftUI

struct WeaponListView: View {
    
    @State var searchingFor = ""
    
    @State var lastVersion = false
    
    @StateObject var viewModel = JSONModel()
    
    var body: some View {
        ZStack{
            NavigationView{
                ZStack{
                    Image("background")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        .ignoresSafeArea()
                    
                    List(weaponsList, id: \.hash) { weapon in
                        NavigationLink(destination: NavigationLazyView(WeaponView(weapon: weapon, viewModel: viewModel))) {
                            WeaponListItem(weapon: weapon)
                        }
                        .listRowBackground(Color.clear)
                        .shadow(color: .black, radius: 5)
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle("Weapons", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Circle()
                            .foregroundColor(lastVersion ? .green : .red)
                        
                        Button {
                            update(initial: false)
                        } label: {
                            Text("Update")
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .navigationViewStyle(.stack)
            .accentColor(Color.white)
            .searchable(text: $searchingFor,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search by name or type")
            
            if viewModel.isLoading != [false, false]{
                LoadingAnimation()
            }
        }
        .onAppear {
            update(initial: true)
        }
        
    }
    
    var weaponsList: [WeaponModel.Weapon] {
        if searchingFor.isEmpty {
            return viewModel.weapons
        }else{
            return viewModel.weapons.filter {$0.weaponType.lowercased().contains(searchingFor.lowercased()) || $0.name.lowercased().contains(searchingFor.lowercased())}
        }
    }
    
    private func update(initial: Bool){
        viewModel.isLoading = [true, true]
        viewModel.updateURLfromManifest(onCompletion: { (successful) in
            initial ? viewModel.initialFetchFromBungie() : viewModel.updateFetchFromBungie()
            
            if viewModel.manifestVersion == VersionPersistence.storage.version || viewModel.manifestVersion == nil{
                lastVersion = true
            }
        })
    }
}

struct WeaponListView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponListView()
    }
}
