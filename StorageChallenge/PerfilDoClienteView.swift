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
            VStack(spacing: 50) {
               
                //MARK: MEDIDAS TITULO E CARD
                VStack(spacing: 14) {
                    HStack {
                        Text("Medidas")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    
                    //MARK: COMPONENTE DE CARD DE MEDIDAS
                    HStack(spacing: 0) {
                        
                        VStack
                        {
                            Image("silhueta")
                            
                        }
                        .padding(.horizontal, 20)
                        
                        
                        
                        
                        VStack {
                            ScrollView {
                                ForEach(clienteExibido.medidas) { medida in
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text("\(medida.descricao)")
                                                .font(.callout)
                                                .fontWeight(.thin)
                                            
                                            Spacer()
                                            Text("\(String(format: "%.1f", medida.valor)) cm")
                                                .fontWeight(.thin)
                                            
                                        }
                                        Divider()
                                            .foregroundStyle(Color(.black))
                                            .padding(.vertical, 12)
                                    }
                                }
                                
                            }
                            .padding(24)
                            .scrollIndicators(.visible) // Garante que a barra de rolagem seja visível
                            
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.amarelo))
                    }
                    .frame(height: 269)
                    
                    .background(Color(.cinzaClaro))
                    .clipShape(.rect(cornerRadius: 20))
                    
                }
                
                
                //MARK: PEDIDOS E LISTA
                VStack(spacing: 14) {
                    HStack {
                        Text("Pedidos")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    
                    //MARK: LISTA DE PEDIDOS
                    ForEach(clienteExibido.pedidos) { pedido in
                        VStack(spacing: 0) {
                            HStack {
                                Text("\(pedido.titulo)")
                                
                                
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(36)
                            
                        }.frame(maxWidth: .infinity)
                            .frame(height: 93)
                            .background(Color(.amarelo))
                            .clipShape(.rect(cornerRadius: 16))
                        
                    }
                }
              
                Spacer()
            }
        
            .padding(.horizontal, 24)
            .padding(.top, 50)
            .navigationTitle(clienteExibido.nome ?? "")
            .navigationBarTitleDisplayMode(.inline)
            
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
        .onAppear {
            
            //            if idDoCliente != nil {
            //                clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente!)
            //                print("buscou o cliente")
            //                print(clientesViewModel.cliente)
            //            }
            //            print(clientesViewModel.cliente.nome)
            //
            if let idDoCliente = idDoCliente {
                clienteExibido = clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente)
           
            } else {
                clienteExibido = clientesViewModel.cliente
            }
            
        }
                

    
       
        
       
    }
    
}

#Preview {
    PerfilDoClienteView( idDoCliente: nil).environmentObject(ClienteViewModel())
}
