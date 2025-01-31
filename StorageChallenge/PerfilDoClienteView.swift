//
//  perfilDoClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI

struct PerfilDoClienteView: View {
    let cliente: ClienteEntity
    @StateObject var clientesViewModel = ClienteViewModel()
    @State var navegarParaListagemDeClientes = false

    var body: some View {
        VStack {
            Text(cliente.nome ?? "")
        }.navigationTitle(cliente.nome ?? "Cliente")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: CadastrarEditarClienteView(tituloDaView: "Editar Cliente")) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                
                ToolbarItem {
                    Button(action: {
                        clientesViewModel.deletarCliente(clienteADeletar: cliente)
                        
                            navegarParaListagemDeClientes = true
                        
                        
                    }, label: {
                        Image(systemName: "trash.circle.fill")
                    })
                    }
                }
            .background(
                        // Navega para a ListarClientesView quando o cliente for deletado
                        NavigationLink(destination: ListarClientesView(), isActive: $navegarParaListagemDeClientes) {
                            EmptyView()
                        }
                    )
            }
    
}

//#Preview {
//    perfilDoClienteView(cliente: ClienteEntity(entity: , insertInto: <#T##NSManagedObjectContext?#>))
//}
