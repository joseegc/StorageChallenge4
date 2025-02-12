


import Foundation
import SwiftData

class SwiftDataImplementacao: BancoDeDados {
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: ClienteModel.self, MedidaModel.self)
        } catch {
            fatalError("Erro ao criar o ModelContainer: \(error)")
        }
    }
    
    @Model
    class ClienteModel {
        @Attribute(.unique) var id: UUID
        var nome: String
        var telefone: String?
        var foto: Data?
        var medidas: [MedidaModel] = []

        init(id: UUID, nome: String, telefone: String?, foto: Data?, medidas: [MedidaModel]) {
            self.id = id
            self.nome = nome
            self.telefone = telefone
            self.foto = foto
            self.medidas = medidas
        }
    }

    @Model
    class MedidaModel {
        @Attribute(.unique) var id: UUID
        var descricao: String
        var valor: Float

        init(id: UUID, descricao: String, valor: Float) {
            self.id = id
            self.descricao = descricao
            self.valor = valor
        }
    }
    
    @MainActor
    func buscarTodosClientes() throws -> [Cliente] {
        print("esta em buscar do swift")
        let context = modelContainer.mainContext
                let fetchDescriptor = FetchDescriptor<ClienteModel>()
                let clientesModel = try context.fetch(fetchDescriptor)
        var clientes: [Cliente] = []
        for clienteBD in clientesModel {
            let cliente = Cliente(id: clienteBD.id, nome: clienteBD.nome, telefone: clienteBD.telefone, foto: clienteBD.foto)
            if !clienteBD.medidas.isEmpty{
                
            }
            clientes.append(cliente)
        }
        return clientes
    }
    
    
    @MainActor 
    func salvarCliente(cliente: Cliente) throws {
        print("esta em salvar do swift")
        let context = modelContainer.mainContext

        // Converter Cliente para ClienteModel antes de salvar
        let medidasModel = cliente.medidas.map { MedidaModel(id: $0.id, descricao: $0.descricao, valor: $0.valor) }

        let clienteModel = ClienteModel(id: cliente.id, nome: cliente.nome, telefone: cliente.telefone, foto: cliente.foto, medidas: medidasModel)

        context.insert(clienteModel)
        try context.save()
    }
    
    func salvarMedidaAoCliente(medida: Medida, cliente: Cliente) throws {
        print("okkkkkk")
    }
    
    func editarCliente(cliente: Cliente) throws {
        print("okkkkkk")
    }
    
    func editarMedidaDoCliente(medida: Medida, cliente: Cliente) throws {
        print("okkkkkk")
    }
    
    
    func deletarCliente(id: UUID) throws {
        print("okkkkkk")
    }
    
    func deletarMedida(id: UUID) throws {
        print("okkkkkk")
    }
    
    func salvarPedido(pedido: Pedido, cliente: Cliente) throws {
        print("okkkkkk")
    }
    
    func editarPedido(pedido: Pedido) throws {
        print("okkkkkk")
    }
    
    func deletarPedido(id: UUID) throws {
        print("okkkkkk")
    }
    
    func salvarReferencia(imagem: Data, pedido: Pedido) throws {
        print("okkkkkk")
    }
    
    func deletarReferencia(id: UUID) throws {
        print("okkkkkk")
    }
    
    

    
}
