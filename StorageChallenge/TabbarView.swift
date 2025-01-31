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
            ListarClientesView()
                .tabItem {
                    Label("Registrar", systemImage: "plus")
                }
            
            // Clientes
            ListarClientesView()
                .tabItem {
                    Label("Registrar", systemImage: "plus")
                }
        }
    }
}

#Preview {
    TabbarView()
}
