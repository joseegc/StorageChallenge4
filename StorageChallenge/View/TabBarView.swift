import SwiftUI

struct TabBarView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            // Clientes
            NavigationStack {
                ListaDeClientesView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Clientes")
            }
            
            // Configurações
            NavigationStack {
                ConfiguracoesView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Configuracoes")
            }
        }.accentColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

#Preview {
    TabBarView()
        .environmentObject(ClienteViewModel(bancoDeDados: SwiftDataImplementacao()))
}
