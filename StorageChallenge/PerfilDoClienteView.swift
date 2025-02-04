//
//  perfilDoClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI

struct PerfilDoClienteView: View {
//    let cliente: ClienteEntity
    let idDoCliente: UUID?
    @State var navegarParaListagemDeClientes = false
    
    @EnvironmentObject var clientesViewModel: ClienteViewModel
    
    
    var body: some View {
        VStack {
            Text(clientesViewModel.cliente.nome )
            Text(clientesViewModel.cliente.telefone ?? "")
            
            if let imageData = clientesViewModel.cliente.foto, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 4))
            }
            else {
            Image(systemName: "person.circle.fill")
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 100, height: 100)
               .clipShape(Circle())
               .overlay(Circle().stroke(Color.blue, lineWidth: 4))
            }
            
            ForEach(clientesViewModel.cliente.medidas ?? []) { medida in
                HStack {
                    Text("\(medida.descricao):")
                    Text("\(String(format: "%.2f", medida.valor)) cm")
                }
            }
            
            
        }.onAppear {
            
            //            if idDoCliente != nil {
            //                clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente!)
            //                print("buscou o cliente")
            //                print(clientesViewModel.cliente)
            //            }
            //            print(clientesViewModel.cliente.nome)
            //
            if let idDoCliente = idDoCliente {
                clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente)
                }
            
        }
                

        
        .toolbar {
            ToolbarItem {
                
                NavigationLink(destination: CadastrarEditarClienteView(idDoCliente: idDoCliente)) {
                    Image(systemName: "pencil.circle.fill")
                }
                
            }
            
        
            ToolbarItem {
                Button(action: {
                    clientesViewModel.deletarCliente(idDoCliente: idDoCliente!)
                            
                         
                        }) {
                            Image(systemName: "trash.circle.fill")
                        }
            }
        }
       
        .navigationTitle(clientesViewModel.cliente.nome ?? "")
       
    }
    
}

#Preview {
    PerfilDoClienteView(idDoCliente: UUID() ).environmentObject(ClienteViewModel())
}
