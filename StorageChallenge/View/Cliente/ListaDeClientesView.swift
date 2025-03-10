import SwiftUI

struct ListaDeClientesView: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel
    @State var nomeBuscado = ""
    @State var mensagemDeErro = "Não há nenhum cliente cadastrado"
    @State var mostrarAlertaDeExcluir = false
    @State var idDeClienteParaDeletar: UUID?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                if clientesViewModel.clientes.isEmpty {
                    VStack {
                        Text(mensagemDeErro)
                            .padding(.top, 180)
                    }
                } else{
                    ForEach(clientesViewModel.clientes){ cliente in
                        CardDeClienteComponent(cliente: cliente)
                            .contextMenu {
                                NavigationLink(destination: CadastrarEditarClienteView(idDoCliente: cliente.id)) {
                                    HStack {
                                        Text("Editar")
                                        Image(systemName: "pencil")
                                    }
                                }
                                
                                Button(role: .destructive) {
                                    mostrarAlertaDeExcluir.toggle()
                                    idDeClienteParaDeletar = cliente.id
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
                            }
                    }
                    Spacer()
                }
            }
            .searchable(text: $nomeBuscado, prompt: "Buscar cliente...")
        }
        .frame(maxWidth: .infinity)
        
        .padding(20)
        .navigationTitle("Clientes")
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CadastrarEditarClienteView()) {
                    Image(systemName: "plus")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.preto)
                }
            }
        }
        
        .actionSheet(isPresented: $mostrarAlertaDeExcluir) {
            ActionSheet(
                title: Text("Excluir Cliente"), // Title of the action sheet
                message: Text("Tem certeza de que deseja excluir este cliente? Esta ação não pode ser desfeita."),
                buttons: [
                    .destructive(Text("Excluir")) {
                        if let idDeClienteParaDeletar {
                            clientesViewModel.deletarCliente(idDoCliente: idDeClienteParaDeletar)
                            clientesViewModel.buscarTodosClientes()
                        }
                    },
                    .cancel()
                ]
            )
        }
        
        .onAppear{
            clientesViewModel.buscarTodosClientes()
        }
        .onChange(of: nomeBuscado) { novoNome in
            if novoNome.isEmpty {
                clientesViewModel.buscarTodosClientes()
                
                if clientesViewModel.clientes.isEmpty {
                    mensagemDeErro = "Não há nenhum cliente cadastrado"
                }
            } else {
                clientesViewModel.buscarClientesPorNome(nome: novoNome)
                
                if clientesViewModel.clientes.isEmpty {
                    mensagemDeErro = "Nenhum cliente encontrado"
                }
            }
        }
        .background(Color(.corDeFundo))
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    NavigationStack{
        ListaDeClientesView()
            .environmentObject(ClienteViewModel(bancoDeDados: SwiftDataImplementacao()))
    }
    
}
