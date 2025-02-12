//
//  perfilDoClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI

struct PerfilDoClienteView: View {
    //    let cliente: ClienteEntity
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var clientesViewModel: ClienteViewModel2
    
    @State var cliente: Cliente
    
    @State var mostrarAlertaDeExcluir = false
    
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
            //                VStack(spacing: 14) {
            //                    HStack {
            //                        Text("Pedidos")
            //                            .font(.title2)
            //                            .bold()
            //                        Spacer()
            //                    }
            //
            //                    //MARK: LISTA DE PEDIDOS
            //                    ForEach(cliente.pedidos) { pedido in
            //                        VStack(spacing: 0) {
            //                            HStack {
            //                                Text("\(pedido.titulo)")
            //
            //
            //                                Spacer()
            //                                Image(systemName: "chevron.right")
            //                            }
            //                            .padding(36)
            //
            //                        }.frame(maxWidth: .infinity)
            //                            .frame(height: 93)
            //                            .background(Color(.amarelo))
            //                            .clipShape(.rect(cornerRadius: 16))
            //                            .foregroundStyle(Color(.pretoFix))
            //
            //
            //                    }
            //                }
            
            Spacer()
        }
        
        
        .padding(.horizontal, 24)
        .padding(.top, 50)
        .navigationTitle(cliente.nome)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.corDeFundo))
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $mostrarAlertaDeExcluir) {
            Alert(
                title: Text("Excluir Cliente"),
                message: Text("Tem certeza de que deseja excluir este cliente? Esta ação não pode ser desfeita."),
                primaryButton: .destructive(Text("Excluir")) {
                    clientesViewModel.deletarCliente(idDoCliente: cliente.id)
                    presentationMode.wrappedValue.dismiss()
                    
                },
                secondaryButton: .cancel()
            )
        }
        .toolbar {
            ToolbarItem {
                
                NavigationLink(destination: CadastrarEditarClienteView(idDoCliente: cliente.id)) {
                    Image(systemName: "pencil")
                }
                
            }
            
            
            ToolbarItem {
                Button() {
                    mostrarAlertaDeExcluir.toggle()
                }
                label: {
                    Image(systemName: "trash.fill")
                        .padding(.leading, -5)
                    
                }
            }
        }
        .onAppear {
            cliente = clientesViewModel.buscarClientePorId(id: cliente.id)!
            
            
            
        }
        
        
        
        
        
        
    }
}

//#Preview {
//    NavigationStack {
//        PerfilDoClienteView( idDoCliente: nil).environmentObject(ClienteViewModel())
//    }
//}
