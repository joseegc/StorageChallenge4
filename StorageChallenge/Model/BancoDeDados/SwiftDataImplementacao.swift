//
//  SwiftDataImplementacao.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

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
        var pedidos: [PedidoModel] = []
        
        init(id: UUID, nome: String, telefone: String?, foto: Data?, medidas: [MedidaModel], pedidos: [PedidoModel]) {
            self.id = id
            self.nome = nome
            self.telefone = telefone
            self.foto = foto
            self.medidas = medidas
            self.pedidos = pedidos
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
    
    @Model
    class PedidoModel {
        @Attribute(.unique) var id: UUID
        var titulo : String
        var observacoes: String?
        var dataDeEntrega: Date
        var statusPagamento: String
        
        
        init(id: UUID = UUID(), titulo: String, observacoes: String?, dataDeEntrega: Date, statusPagamento: String) {
            self.id = id
            self.titulo = titulo
            self.observacoes = observacoes
            self.dataDeEntrega = dataDeEntrega
            self.statusPagamento = statusPagamento
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
            var cliente = Cliente(id: clienteBD.id, nome: clienteBD.nome, telefone: clienteBD.telefone!, foto: clienteBD.foto)
            if !clienteBD.medidas.isEmpty{
                for medidaBD in clienteBD.medidas {
                    let medida = Medida(id: medidaBD.id, descricao: medidaBD.descricao, valor: medidaBD.valor)
                    print("MEDIDA BD")
                    print(medidaBD.descricao)
                    cliente.medidas.append(medida)
                }
            }
            if !clienteBD.pedidos.isEmpty{
                for pedidoBD in clienteBD.pedidos {
                    let pedido = Pedido(id: pedidoBD.id,titulo: pedidoBD.titulo, dataDeEntrega: pedidoBD.dataDeEntrega, statusPagamento: pedidoBD.statusPagamento)
                    cliente.pedidos.append(pedido)
                }
            }
            clientes.append(cliente)
        }
        return clientes
    }
    
    @MainActor
    func buscarPedidoPorId(pedido: Pedido) throws -> Pedido? {
        let context = modelContainer.mainContext
        
        let predicate = #Predicate<PedidoModel> { pedidoBD in
            pedidoBD.id == pedido.id
        }
        
        let fetchDescriptor = FetchDescriptor<PedidoModel>(predicate: predicate)
        
        // Busca o primeiro cliente que corresponde ao ID
        guard let pedidoBD = try context.fetch(fetchDescriptor).first else {
            return nil
        }
        
        // Converte para o modelo Cliente
        var pedido = Pedido(id: pedidoBD.id, titulo: pedidoBD.titulo, observacoes: pedidoBD.observacoes, dataDeEntrega: pedidoBD.dataDeEntrega, cliente: pedido.cliente, statusPagamento: pedidoBD.statusPagamento)
        
        return pedido
    }
    
    
    
    @MainActor
    func buscarClientesPorNome(nome: String) throws -> [Cliente] {
        let nomeNormalizado = nome.trimmingCharacters(in: .whitespaces).lowercased()
        let context = modelContainer.mainContext
        
        // Busca todos os clientes (não filtra no banco)
        let fetchDescriptor = FetchDescriptor<ClienteModel>()
        let clientesModel = try context.fetch(fetchDescriptor)
        
        // Filtra na memória de forma case insensitive
        let clientesFiltrados = clientesModel.filter { cliente in
            cliente.nome.lowercased().contains(nomeNormalizado)
        }
        
        var clientes: [Cliente] = []
        for clienteBD in clientesFiltrados {
            var cliente = Cliente(id: clienteBD.id, nome: clienteBD.nome, telefone: clienteBD.telefone!, foto: clienteBD.foto)
            if !clienteBD.medidas.isEmpty{
                for medidaBD in clienteBD.medidas {
                    let medida = Medida(id: medidaBD.id, descricao: medidaBD.descricao, valor: medidaBD.valor)
                    cliente.medidas.append(medida)
                }
            }
            clientes.append(cliente)
        }
        
        return clientes
    }
    
    @MainActor
    func buscarClientePorId(id: UUID) throws -> Cliente? {
        let context = modelContainer.mainContext
        
        let predicate = #Predicate<ClienteModel> { cliente in
            cliente.id == id
        }
        
        let fetchDescriptor = FetchDescriptor<ClienteModel>(predicate: predicate)
        
        // Busca o primeiro cliente que corresponde ao ID
        guard let clienteBD = try context.fetch(fetchDescriptor).first else {
            return nil
        }
        
        // Converte para o modelo Cliente
        var cliente = Cliente(id: clienteBD.id, nome: clienteBD.nome, telefone: clienteBD.telefone!, foto: clienteBD.foto)
        
        
        for medidaBD in clienteBD.medidas {
            let medida = Medida(id: medidaBD.id, descricao: medidaBD.descricao, valor: medidaBD.valor)
            cliente.medidas.append(medida)
        }
        
        print(clienteBD.pedidos.count)
        
        for pedidoBD in clienteBD.pedidos {
            let pedido = Pedido(id: pedidoBD.id,titulo: pedidoBD.titulo, dataDeEntrega: pedidoBD.dataDeEntrega, cliente: cliente, statusPagamento: pedidoBD.statusPagamento)
            print(pedido.titulo)
            cliente.pedidos.append(pedido)
        }
        
        
        return cliente
    }
    
    
    
    
    @MainActor
    func salvarCliente(cliente: Cliente) throws {
        let context = modelContainer.mainContext
        
        // Converter Cliente para ClienteModel antes de salvar
        let medidasModel = cliente.medidas.map { MedidaModel(id: $0.id, descricao: $0.descricao, valor: $0.valor) }
        let pedidosModel = cliente.pedidos.map { PedidoModel(id: $0.id, titulo: $0.titulo, observacoes: $0.observacoes, dataDeEntrega: $0.dataDeEntrega, statusPagamento: $0.statusPagamento) }
        let clienteModel = ClienteModel(id: UUID(), nome: cliente.nome, telefone: cliente.telefone, foto: cliente.foto, medidas: medidasModel, pedidos: pedidosModel)
        
        context.insert(clienteModel)
        try context.save()
    }
    
    @MainActor
    func deletarCliente(id: UUID) throws {
        
        let context = modelContainer.mainContext
        
        let predicate = #Predicate<ClienteModel> { cliente in
            cliente.id == id
        }
        
        let fetchDescriptor = FetchDescriptor<ClienteModel>(predicate: predicate)
        
        
        if let clienteBD = try context.fetch(fetchDescriptor).first{
            context.delete(clienteBD)
        }
        
    }
    
    @MainActor
    func editarCliente(cliente: Cliente) throws {
        let context = modelContainer.mainContext
        
        let idCliente = cliente.id!
        
        print(idCliente)
        
        let predicate = #Predicate<ClienteModel> { clienteBD in
            clienteBD.id == idCliente
        }
        
        let fetchDescriptor = FetchDescriptor<ClienteModel>(predicate: predicate)
        
        if let clienteBD = try context.fetch(fetchDescriptor).first  {
            
            if clienteBD.nome != cliente.nome {
                clienteBD.nome = cliente.nome
            }
            
            if clienteBD.telefone != cliente.telefone {
                clienteBD.telefone = cliente.telefone
            }
            
            if clienteBD.foto != cliente.foto {
                clienteBD.foto = cliente.foto
            }
            
            for medida in cliente.medidas {
                let idMedida = medida.id
                let predicate = #Predicate<MedidaModel> { medidaBD in
                    medidaBD.id == idMedida
                }
                
                let fetchDescriptor = FetchDescriptor<MedidaModel>(predicate: predicate)
                
                if let medidaBD = try context.fetch(fetchDescriptor).first  {
                    if medidaBD.descricao != medida.descricao {
                        medidaBD.descricao = medida.descricao
                    }
                    
                    if medidaBD.valor != medida.valor {
                        medidaBD.valor = medida.valor
                    }
                } else {
                    let medida = MedidaModel(id: medida.id, descricao: medida.descricao, valor: medida.valor)
                    context.insert(medida)
                    clienteBD.medidas.append(medida)
                }
                
            }
        }
    }
    
    
    @MainActor
    func deletarMedida(id: UUID) throws {
        let context = modelContainer.mainContext
        
        let predicate = #Predicate<MedidaModel> { medidaBD in
            medidaBD.id == id
        }
        
        let fetchDescriptor = FetchDescriptor<MedidaModel>(predicate: predicate)
        
        
        if let medidaBD = try context.fetch(fetchDescriptor).first{
            context.delete(medidaBD)
        }
        
    }
    
    @MainActor
    func salvarPedido(pedido: Pedido) throws {
        let context = modelContainer.mainContext
        
        
        let idCliente = pedido.cliente.id!
        
        let predicate = #Predicate<ClienteModel> { clienteBD in
            clienteBD.id == idCliente
        }
        
        let fetchDescriptor = FetchDescriptor<ClienteModel>(predicate: predicate)
        
        if let clienteBD = try context.fetch(fetchDescriptor).first  {
            let pedidoModel = PedidoModel(id: pedido.id, titulo: pedido.titulo, observacoes: pedido.observacoes, dataDeEntrega: pedido.dataDeEntrega, statusPagamento: pedido.statusPagamento)
            print("salvando no swift")
            print(pedidoModel.id)
            context.insert(pedidoModel)
            clienteBD.pedidos.append(pedidoModel)
        }
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
