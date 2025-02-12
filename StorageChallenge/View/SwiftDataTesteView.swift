import SwiftUI
import SwiftData

struct SwiftDataTesteView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var clienteViewModel = SwiftDataModel()

    // Inicializando a ViewModel e passando o modelContext
 
    var body: some View {
        VStack {
            // Botão para adicionar um cliente
            Button {
                clienteViewModel.adicionarCliente(cliente: Cliente(nome: "Jorge"))
            } label: {
                Text("Add")
            }

            // Exibindo os clientes da lista
            List(clienteViewModel.clientes) { cliente in
                Text(cliente.nome)
            }
        }
        .onAppear {
            // Buscar os clientes quando a view aparecer
            clienteViewModel.buscarTodosClientes()
        }
    }
}

#Preview {
    SwiftDataTesteView()
        .modelContainer(for: ClienteSwiftData.self, inMemory: true)
}
