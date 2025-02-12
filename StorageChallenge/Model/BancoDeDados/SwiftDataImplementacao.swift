import SwiftUI
import SwiftData

class SwiftDataModel: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Published var clientes: [ClienteSwiftData] = []

    static var shared = SwiftDataModel()
    // Função para buscar todos os clientes
    func buscarTodosClientes() {
        let fetchDescriptor = FetchDescriptor<ClienteSwiftData>()
        
        do {
            self.clientes = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Erro ao buscar clientes: \(error)")
        }
    }

    // Função para adicionar um cliente
    func adicionarCliente(cliente: Cliente) {
        let clienteAdicionado = ClienteSwiftData()
        clienteAdicionado.nome = cliente.nome
        
        modelContext.insert(clienteAdicionado)
        
        do {
            try modelContext.save()  // Certificando-se de que o cliente é salvo no banco de dados
            print("Cliente \(cliente.nome) adicionado com sucesso.")
            // Após adicionar, buscamos todos os clientes para atualizar a lista
            buscarTodosClientes()
        } catch {
            print("Erro ao salvar cliente: \(error)")
        }
    }
    
    func deletarCliente(cliente: ClienteSwiftData) {
            modelContext.delete(cliente) // Remove o cliente do contexto

            do {
                try modelContext.save() // Salva as alterações no modelo
                print("Cliente \(cliente.nome) deletado com sucesso.")
                buscarTodosClientes() // Atualiza a lista de clientes após a exclusão
            } catch {
                print("Erro ao deletar cliente: \(error)")
            }
        }
}
