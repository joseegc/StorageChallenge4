//
//  TabbarView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            // Pedidos
            NavigationStack{
                ListarPedidosView()
            }.tabItem {
                Label("Pedidos", systemImage: "calendar")
                }
            
            // Clientes
            NavigationStack{
                ListaDeClientes()
            }.tabItem {
                    Label("Clientes", systemImage: "person.3.fill")
                }
        }
        
    }
}

#Preview {
    TabBarView()
        .environmentObject(ClienteViewModel())
        .environmentObject(PedidoViewModel())
}
