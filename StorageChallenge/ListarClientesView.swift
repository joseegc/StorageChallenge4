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
                   
                    ForEach(clientesViewModel.clientesSalvos) { cliente in
                        
                        NavigationLink(destination: PerfilDoClienteView(idDoCliente: cliente.id)) {
                            Text(cliente.nome ?? "Sem nome")
                               
//                                .onTapGesture {
//                                    clientesViewModel.atualizarNoBanco(entidade: cliente)
//                                }
                        }
                        
                    }.onAppear {

                        clientesViewModel.buscarClientesNoBanco()
                        print(clientesViewModel.clientesSalvos)
                        print("atualizano")
                    }
                    
                    
                }
            }
            .task {
                clientesViewModel.buscarClientesNoBanco()
                print(clientesViewModel.clientesSalvos)
                print("atualizano")
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
//    ListarClientesView().environmentObject(ClienteViewModel())
//}
