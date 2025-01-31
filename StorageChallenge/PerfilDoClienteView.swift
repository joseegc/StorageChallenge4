//
//  perfilDoClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI

struct PerfilDoClienteView: View {
    let cliente: ClienteEntity
    @State var navegarParaListagemDeClientes = false
    
    @EnvironmentObject var clientesViewModel: ClienteViewModel

   
    var body: some View {
        VStack {
            Text(cliente.nome ?? "")
            Text(cliente.telefone ?? "")
            
            ForEach((cliente.medidas?.allObjects as? [MedidaEntity] ?? []).reversed(), id: \.self) { medida in
                HStack {
                    Text("\(medida.descricao ?? "Sem descrição"):")
                    Text("\(String(format: "%.2f", medida.valor)) cm")
                }
            }


        }.navigationTitle(cliente.nome ?? "Cliente")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: CadastrarEditarClienteView(tituloDaView: "Editar Cliente", cliente: cliente)) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                
                ToolbarItem {
                    Button(action: {
                        clientesViewModel.deletarCliente(clienteADeletar: cliente)
                        
                        if navegarParaListagemDeClientes {
                            navegarParaListagemDeClientes = true
                        }
                        
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
