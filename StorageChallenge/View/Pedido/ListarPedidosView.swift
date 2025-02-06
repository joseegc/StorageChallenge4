//
//  ListaPedidosView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct ListarPedidosView: View {
    @EnvironmentObject var pedidoViewModel: PedidoViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                   
                    ForEach(pedidoViewModel.pedidos) { pedido in
                        
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
