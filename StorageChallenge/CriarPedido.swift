//
//  CriarPedido.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct CriarPedido: View {
    @ObservedObject var pedidoVM = PedidoViewModel()
    
    
    var body: some View {
        HStack{
            Text("Cliente:")
            Text(pedidoVM.pedido?.cliente.nome ?? "")
        }
        HStack {
            Text("Titulo:")
                .frame(width: 100, alignment: .leading) // Alinhar o título
            TextField("Titulo", text: $pedidoVM.pedido?.titulo ?? "")
        }
        .padding()
        Divider()
        DatePicker(
                "Data de Entrega",
                selection: $pedidoVM.pedido.dataDeEntrega,
                displayedComponents: [.date]
            )
        Divider()
        
    }
}

#Preview {
    CriarPedido(pedido: pedidosTeste[0])
}
