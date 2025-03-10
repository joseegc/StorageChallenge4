import SwiftUI

struct PerfilDoClienteView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var clientesViewModel: ClienteViewModel
    
    @State var cliente: Cliente = Cliente()
    
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
                CardDeMedidasComponent(cliente: cliente)
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
        .actionSheet(isPresented: $mostrarAlertaDeExcluir) {
            ActionSheet(
                title: Text("Excluir Cliente"),
                message: Text("Tem certeza de que deseja excluir \(cliente.nome)? Esta ação não pode ser desfeita."),
                buttons: [
                    .destructive(Text("Excluir")) {
                        
                        clientesViewModel.deletarCliente(idDoCliente: cliente.id)
                        presentationMode.wrappedValue.dismiss()
                    },
                    .cancel()
                ]
            )
        }
        
        .toolbar {
            
            Menu {
                NavigationLink(destination: CadastrarEditarClienteView(idDoCliente: cliente.id)) {
                    HStack {
                        Text("Editar")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                
                Button(role: .destructive) {
                    mostrarAlertaDeExcluir.toggle()
                }
            label: {
                HStack {
                    Text("Apagar")
                        .foregroundStyle(Color.red)
                    Spacer()
                    Image(systemName: "trash")
                        .foregroundStyle(Color.red)
                }
            }
            } label: {
                Label("Opções", systemImage: "ellipsis.circle")
            }
            
            
        }
        
        .onAppear {
            if let clienteBuscado = clientesViewModel.buscarClientePorId(id: cliente.id) {
                cliente = clienteBuscado
            }
        }
    }
}

#Preview {
    NavigationStack {
        PerfilDoClienteView()
            .environmentObject(ClienteViewModel(bancoDeDados: SwiftDataImplementacao()))
    }
}
