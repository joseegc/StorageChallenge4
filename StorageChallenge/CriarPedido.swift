//
//  CriarPedido.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct CriarPedido: View {
    @ObservedObject var pedidoVM = PedidoViewModel()
    @State var pedido: Pedido? = nil
    @State var cliente: Cliente
    @State private var date: Date = Date()
    
    var body: some View {
        HStack{
            Text("Cliente:")
            Text(cliente.nome)
        }
        HStack {
            Text("Titulo:")
                .frame(width: 100, alignment: .leading) // Alinhar o título
            Text(pedido?.titulo ?? " ")
        }
        .padding()
        Divider()
        DatePicker(
                "Data de Entrega",
                selection: Binding(
                                    get: { pedido?.dataDeEntrega ?? date },
                                    set: { newDate in
                                        if pedido != nil {
                                            pedido?.dataDeEntrega = newDate
                                        } else {
                                            date = newDate
                                        }
                                    }
                                ),
                displayedComponents: [.date]
            )
        Divider()
        Text("Tela de cadastrar e editar \(pedido?.titulo ?? "vazio")")
        
    }
}

#Preview {
    CriarPedido(
        cliente: pedidosTeste[0].cliente
    )
}
