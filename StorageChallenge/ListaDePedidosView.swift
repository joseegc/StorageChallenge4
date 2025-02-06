//
//  ListaPedidosView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI



struct ListaDePedidosView: View {
    @EnvironmentObject var pedidoViewModel: PedidoViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                   
                    ForEach(pedidoViewModel.pedidos) { pedido in
//                        
//                        NavigationLink(destination: PerfilDoClienteView(idDoCliente: cliente.id)) {
//                            Text(cliente.nome ?? "Sem nome")
//                               
//                        }
                        
                        Text(pedido.titulo)
                        
                    }.onAppear {

                        pedidoViewModel.buscarTodosOsPedidos()
                    }
                    
                    
                }
            }
            .task {
                pedidoViewModel.buscarTodosOsPedidos()
            }
            .padding(.horizontal)
            .navigationTitle("Pedidos")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: CadastrarEditarClienteView()){
                        Text("Criar")
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    NavigationStack{
       //ListarPedidosView()
    }
}
