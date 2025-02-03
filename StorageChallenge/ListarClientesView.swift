//
//  ClientesView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI


struct ListarClientesView: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                   
                    ForEach(clientesViewModel.clientesSalvos, id: \.self) { cliente in
                        
                        NavigationLink(destination: PerfilDoClienteView(cliente: cliente)) {
                            Text(cliente.nome ?? "Sem nome")
                               
//                                .onTapGesture {
//                                    clientesViewModel.atualizarNoBanco(entidade: cliente)
//                                }
                        }
                        
                    }
                    
                    
                }
            }
            .padding(.horizontal)
            .navigationTitle("Clientes")
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

//#Preview {
//    ListarClientesView(clientesViewModel: ClienteViewModel())
//}
