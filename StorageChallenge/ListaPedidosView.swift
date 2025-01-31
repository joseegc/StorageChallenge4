//
//  ListaPedidosView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct ListaPedidosView: View {
    @State var pedidos: [Pedido] = []
    
    var body: some View {
        List(pedidos){
            Text($0.titulo)
        }
    }
}

#Preview {
    ListaPedidosView(
    pedidos: [Pedido(titulo: "Pedido 1", statusDaEntrega: "Pendente", observacoes: "Teste obs")]
    )
}
