//
//  ListaPedidosView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI



struct ListaDePedidosView: View {
    @State var pedidos: [Pedido] = []
    
    var body: some View {
        
        if pedidos.isEmpty {
            Text("Nenhum pedido registrado!")
        } else{
            ForEach(pedidos){pedido in
                Text(pedido.titulo)
            }
        }
    }
}


#Preview {
    NavigationStack{
        ListaDePedidosView()
    }
}
