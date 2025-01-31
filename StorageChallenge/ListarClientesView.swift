//
//  ClientesView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI


struct ListarClientesView: View {
    @StateObject var clientesViewModel = ClienteViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text(clientesViewModel.cliente.nome )
                    Text("Cadastrar Cliente")
                    TextField("nome", text: $clientesViewModel.cliente.nome)
                    
                    Button(action: {
                        clientesViewModel.adicionarAoBanco()
                    }, label: {
                        Text("Enviar")
                            .frame(width: 200, height: 50)
                            .background(.blue)
                            .foregroundStyle(Color(.white))
                    })
                    
                    
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

#Preview {
    ListarClientesView(clientesViewModel: ClienteViewModel())
}
