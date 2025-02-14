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
                NavigationLink(destination: ExibirPedidoView(pedido: pedido)){
                    VStack(spacing:0){
                        VStack{
                            HStack{
                                Text(pedido.titulo)
                                    .font(.title2)
                                Spacer()
                            }.padding(15)
                        }
                        .background(.amarelo)
                        HStack{
                            HStack{
                                Text("Entrega: \(pedido.dataDeEntrega.formatted(date: .numeric, time: .omitted))")
                                Spacer()
                            }
                        }.padding(.horizontal, 15).padding(.vertical, 5).background(.cinzaEscuro)
                    }
                }.frame(maxWidth: .infinity)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
        }
    }
}


#Preview {
    NavigationStack{
        ListaDePedidosView()
    }
}
