//
//  ListaPedidosView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct ListaPedidosView: View {
    @ObservedObject var pedidoVM = PedidoViewModel()
    
    var body: some View {
        List(pedidoVM.pedidos){pedido in
            NavigationLink {
                CriarPedido(pedido: pedido, cliente: pedidosTeste[0].cliente)
            } label: {
                Text(pedido.titulo)
            }
        }.navigationTitle("Pedidos")
            .toolbar {
                // Botão de adicionar na parte superior direita
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ListarClientesView()) {
                        Image(systemName: "plus")
                    }
                }
            }
    }
}

#Preview {
    NavigationStack{
        ListaPedidosView()
    }
}
