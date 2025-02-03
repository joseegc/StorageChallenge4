//
//  TabbarView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct TabbarView: View {
    
    var body: some View {
        TabView {
            // Pedidos
            ListaPedidosView()
                .tabItem {
                    Label("Pedidos", systemImage: "calendar")
                }
            
            // Clientes
            ListarClientesView()
                .tabItem {
                    Label("Clientes", systemImage: "person.3.fill")
                }
        }
    }
}

#Preview {
    TabbarView()
        .environmentObject(ClienteViewModel())
}
