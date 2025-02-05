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
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var clientesViewModel: ClienteViewModel
    
    @State var clienteExibido = Cliente()
    
    var body: some View {
        VStack {
            Text(clienteExibido.nome )
            Text(clienteExibido.telefone ?? "")
            
            if let imageData = clienteExibido.foto, let uiImage = UIImage(data: imageData) {
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
            
            ForEach(clienteExibido.medidas) { medida in
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
                clienteExibido = clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente)
            print("entrei e peguei o id")
                print(clienteExibido)
            } else {
                print("nem chegou apegar o id")
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
                    presentationMode.wrappedValue.dismiss()

                         
                        }) {
                            Image(systemName: "trash.circle.fill")
                        }
            }
        }
       
        .navigationTitle(clienteExibido.nome ?? "")
       
    }
    
}

#Preview {
    PerfilDoClienteView(idDoCliente: UUID() ).environmentObject(ClienteViewModel())
}
