//
//  perfilDoClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI

struct PerfilDoClienteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var clientesViewModel: ClienteViewModel
    
    @State var cliente: Cliente
    
    @State var mostrarAlertaDeExcluir = false
    
    var body: some View {
        ScrollView{
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
                            if cliente.medidas.isEmpty {
                                VStack {
                                    Spacer()
                                    Text("Sem medidas cadastradas")
                                        .foregroundStyle(Color.pretoFix)
                                    
                                    Spacer()
                                }
                            }else {
                                ScrollView {
                                    ForEach(cliente.medidas) { medida in
                                        VStack(spacing: 0) {
                                            HStack {
                                                Text("\(medida.descricao)")
                                                    .frame(width: 100, alignment: .leading)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .multilineTextAlignment(.leading)
                                                    .font(.callout)
                                                    .fontWeight(.thin)
                                                
                                                
                                                Spacer()
                                                Text("\(String(format: "%.1f", medida.valor)) cm")
                                                    .fontWeight(.thin)
                                                
                                            }
                                            Divider()
                                                .padding(.vertical, 12)
                                        }
                                        .foregroundStyle(Color(.pretoFix))
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    //                                    .scrollIndicators(.visible) // Garante que a barra de rolagem seja visível
                                }
                                .padding(24)
                                .scrollIndicators(.visible)
                            }
                            
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
                        NavigationLink(destination: CadastrarEditarPedidoView(cliente: cliente)) {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ListaDePedidosView(pedidos: cliente.pedidos)
                }
                .navigationTitle(cliente.nome)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color(.corDeFundo))
                .edgesIgnoringSafeArea(.bottom)
                .alert(isPresented: $mostrarAlertaDeExcluir) {
                    Alert(
                        title: Text("Excluir Cliente"),
                        message: Text("Tem certeza de que deseja excluir este cliente? Esta ação não pode ser desfeita."),
                        primaryButton: .destructive(Text("Excluir")) {
                            clientesViewModel.deletarCliente(idDoCliente: cliente.id!)
                            presentationMode.wrappedValue.dismiss()
                            
                        },
                        secondaryButton: .cancel()
                    )
                }
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: CadastrarEditarClienteView(idDoCliente: cliente.id)){
                            Image(systemName: "pencil")
                        }
                    }
                    ToolbarItem {
                        Button(action: {
                            mostrarAlertaDeExcluir.toggle()
                        }, label: {
                            Image(systemName: "trash.fill")
                        })
                    }
                }
                .onAppear {
                    cliente = clientesViewModel.buscarClientePorId(id: cliente.id!)!
                }
            }
        }.padding(25).scrollIndicators(.hidden)
        
    }
}


#Preview {
    NavigationStack {
        PerfilDoClienteView( cliente: Cliente(id: UUID(), nome: "Jorge", telefone: "11966666666")).environmentObject(ClienteViewModel(bancoDeDados: SwiftDataImplementacao()))
    }
}
