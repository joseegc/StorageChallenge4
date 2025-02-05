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
                   
                    ForEach(clientesViewModel.clientes) { cliente in
                        
                        NavigationLink(destination: PerfilDoClienteView(idDoCliente: cliente.id)) {
                            Text(cliente.nome ?? "Sem nome")
                               
                        }.onAppear {
                            if cliente.nome == "A" {
                                print("IMPRIMINDO A ENTIDADE NO FOREACH")
                                print(cliente)
                            }
                        }

                        
                    }
                    
                }
            }
            .task {
                clientesViewModel.buscarTodosClientes()
                clientesViewModel.buscarClientesNoBanco()
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
