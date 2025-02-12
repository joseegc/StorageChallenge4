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
    @EnvironmentObject var viewModel: ClienteViewModel2
    
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
                                    Text("Sem medidas cadastradas!")
                                        .foregroundStyle(Color.pretoFix)
                                    Spacer()
                                }
                            }else {
                                ScrollView {
                                    ForEach(cliente.medidas) { medida in
                                        VStack(spacing: 0) {
                                            HStack {
                                                Text("\(medida.descricao)")
                                                    .frame(width: 100, alignment: .leading)  // Define uma largura fixa e alinha o texto à esquerda
                                                    .lineLimit(1)       // Limita a uma linha
                                                    .truncationMode(.tail) // Adiciona reticências no final do texto
                                                    .multilineTextAlignment(.leading)  // Alinha o texto à esquerda
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
                                    
                                }
                            }
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.amarelo))
                    }
                    .frame(height: 269)
                    .background(Color(.cinzaClaro))
                    .clipShape(.rect(cornerRadius: 20)) 
                }
                VStack{
                    HStack{
                        Text("Pedidos")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination: CadastrarEditarPedidoView(cliente: cliente)) {
                            Image(systemName: "plus")
                        }
                    }
                    if(cliente.pedidos.isEmpty){
                        Text("Nenhum pedido registrado!")
                    } else {
                        ListaDePedidosView()
                    }
                }
            }
        }.padding(.horizontal, 24)
            .navigationTitle(cliente.nome)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.corDeFundo))
            .edgesIgnoringSafeArea(.bottom)
            .alert(isPresented: $mostrarAlertaDeExcluir) {
                Alert(
                    title: Text("Excluir Cliente"),
                    message: Text("Tem certeza de que deseja excluir este cliente? Esta ação não pode ser desfeita."),
                    primaryButton: .destructive(Text("Excluir")) {
                        print("chamou deletar")
                        viewModel.deletarCliente(idDoCliente: cliente.id)
                        
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
            .toolbar {
                ToolbarItem {
                    
                    NavigationLink(destination: CadastrarEditarClienteView(idDoCliente: cliente.id)) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                ToolbarItem {
                    Button {
                        mostrarAlertaDeExcluir.toggle()
                    }
                label: {
                    Image(systemName: "trash.circle.fill")
                        .padding(.leading, -5)
                }
                }
            }
        
    }
    
}

#Preview {
    NavigationStack {
        PerfilDoClienteView(cliente: Cliente(nome: "Teste"))
    }
}
