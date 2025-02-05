//
//  CoreDataViewModel.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import Foundation
import CoreData

class CoreDataModel: ObservableObject {
    let container: NSPersistentContainer
    //    @Published var clientesSalvos: [ClienteEntity] = []
    
    static let shared = CoreDataModel()
    
    
    init() {
        container = NSPersistentContainer(name: "AppContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Erro ao buscar o container \(error)")
            }
        }
    }
    
    // MARK: FETCH
    func buscarClientes() -> [ClienteEntity] {
        let requisicao = NSFetchRequest<ClienteEntity>(entityName: "ClienteEntity")
        
        // faz a busca no container e alimenta a array de pedidosSalvos
        do {
            let resposta = try container.viewContext.fetch(requisicao)
            
            return resposta
        } catch let error {
            print("erro ao buscar clientes \(error)")
        }
        return []
    }
    
    
    
    func adicionarPedido(titulo: String) {
        let novoPedido = PedidoEntity(context: container.viewContext)
        novoPedido.titulo = titulo
        novoPedido.dataDeEntrega = Date()
        salvar()
    }
    
    
    // MARK: Tentando fazer os genericos
    func adicionar<Objeto>(objeto: Objeto) {
        let contexto = container.viewContext
        var entidade : NSManagedObject?
        
        if objeto is Cliente {
            entidade = ClienteEntity(context: contexto)
            
        }
        
        // Usando Reflection para obter as propriedades do objeto e seus valores
        let mirror = Mirror(reflecting: objeto)
        
        if let entidade = entidade {
            // Iterando sobre as propriedades do objeto
            for (nomePropriedade, valorPropriedade) in mirror.children {
                guard let nomePropriedade = nomePropriedade else { continue }
                entidade.setValue(valorPropriedade, forKey: nomePropriedade)
            }
            
            salvar()
        }
    }
    
    func atualizarCliente(cliente: Cliente, clienteEntity: ClienteEntity) {
        clienteEntity.id = cliente.id
        clienteEntity.nome = cliente.nome
        clienteEntity.telefone = cliente.telefone
        
        //Vai usar em medidas mesma ideia
        
        //        if clienteEntity.foto == nil {
        //            clienteEntity.foto = FotoEntity(context: CoreDataModel.shared.container.viewContext)
        //        }
        //        
        //        if let clienteFoto = cliente.foto {
        //            clienteEntity.foto?.imagem = clienteFoto.imagem
        //            clienteEntity.foto?.cliente = clienteEntity
        //        }
        
        clienteEntity.foto = cliente.foto
        
        
        if cliente.medidas != nil {
            for medida in cliente.medidas ?? [] {
                
                
                var medidaEntity = verificarSeMedidaExiste(medida: medida)
                
                if medidaEntity == nil {
                    medidaEntity = MedidaEntity(context: CoreDataModel.shared.container.viewContext)
                    print("nova medida")
                }
                
                print(medidaEntity?.descricao)
                print(medida.descricao)
                medidaEntity?.descricao = medida.descricao
                medidaEntity?.valor = medida.valor
                print("editoou")
                print(medidaEntity?.descricao)
            }
        }
    }
    //        if let pedidos = cliente.pedidos {
    //            clienteEntity.pedidos = NSSet(array: pedidos)
    //        }
    
    
    
    func verificarSeMedidaExiste(medida: Medida) -> MedidaEntity? {
        // Buscar cliente existente no Core Data pelo ID (convertendo UUID para String)
        let fetchRequest: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", medida.id.uuidString)
        
        do {
            let medidasExistentes = try container.viewContext.fetch(fetchRequest)
            
            if let medidaExistente = medidasExistentes.first {
                print("A MEDIDA EXISTE")
                return medidaExistente
            } else {
                print("A MEDIDA NAO EXISTE")
                return nil
            }
        } catch {
            print("Erro ao buscar cliente no Core Data: \(error)")
        }
        return nil
    }
    
    
    func adicionarCliente(cliente: Cliente) {
        // Buscar cliente existente no Core Data pelo ID (convertendo UUID para String)
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cliente.id.uuidString)
        
        do {
            let clientesExistentes = try container.viewContext.fetch(fetchRequest)
            
            if let clienteExistente = clientesExistentes.first {
                // Se o cliente já existe, chama a função editarCliente
                atualizarCliente(cliente: cliente, clienteEntity: clienteExistente)
                print("ENTIDADE")
                print(clienteExistente)
                salvar()
            } else {
                // Caso contrário, adiciona um novo cliente
                let novoClienteEntity = ClienteEntity(context: container.viewContext)
                atualizarCliente(cliente: cliente, clienteEntity: novoClienteEntity)
                salvar()
            }
        } catch {
            print("Erro ao buscar cliente no Core Data: \(error)")
        }
    }
    
    func salvarCliente(cliente: Cliente) throws {
        let novoCliente = ClienteEntity(context: container.viewContext)
        novoCliente.id = cliente.id
        novoCliente.nome = cliente.nome
        novoCliente.telefone = cliente.telefone
        novoCliente.foto = cliente.foto
        try container.viewContext.save()

        for medida in cliente.medidas  {
            try salvarMedidaAoCliente(medida: medida, cliente: cliente)
            print("salvou a medida \(medida.descricao)")
        }
        
        print("O CLIENTE SALVO É")
        print(novoCliente)
    }
    
    func salvarMedidaAoCliente(medida: Medida, cliente: Cliente) throws{
        let novaMedida = MedidaEntity(context: container.viewContext)
        novaMedida.id = medida.id
        novaMedida.descricao = medida.descricao
        novaMedida.valor = medida.valor
        
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cliente.id.uuidString)
        
        do {
               let retorno = try container.viewContext.fetch(fetchRequest)
               if let clienteBD = retorno.first {
                   novaMedida.cliente = clienteBD
                   print("Associação da medida \(medida.id) com o cliente \(cliente.id) feita com sucesso.")
               } else {
                   print("Cliente não encontrado no Core Data para associar a medida.")
               }
               try container.viewContext.save()
           } catch {
               print("Erro ao salvar medida do cliente no Core Data: \(error)")
           }
    }
    
    func editarCliente(cliente: Cliente) throws{
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cliente.id.uuidString)
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            var clienteBD = retorno.first
            if clienteBD?.nome != cliente.nome {
                clienteBD?.nome = cliente.nome
            }
            
            if clienteBD?.telefone != cliente.telefone {
                clienteBD?.telefone = cliente.telefone
            }
            
            if clienteBD?.foto != cliente.foto {
                clienteBD?.foto = cliente.foto
            }
            
            for medida in cliente.medidas{
                try editarMedidaDoCliente(medida: medida, cliente: cliente)
            }
            
            try container.viewContext.save()
            
        } catch {
            print("Erro ao editar cliente no Core Data: \(error)")
        }
        
    }
    
    func editarMedidaDoCliente(medida: Medida, cliente: Cliente) throws{
        let fetchRequestMedida: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
        fetchRequestMedida.predicate = NSPredicate(format: "id == %@", medida.id.uuidString)
        do{
            let retornoMedida = try container.viewContext.fetch(fetchRequestMedida)
            var medidaBD = retornoMedida.first
            if medidaBD == nil {
                try salvarMedidaAoCliente(medida: medida, cliente: cliente)
                
            } else {
                if medidaBD?.descricao != medida.descricao {
                    medidaBD?.descricao = medida.descricao
                }
                if medidaBD?.valor != medida.valor {
                    medidaBD?.valor = medida.valor
                }
                try container.viewContext.save()
            }
        } catch {
            print("Erro ao editar medida no Core Data: \(error)")
        }
    }
    
    func buscarTodosClientes() throws -> [Cliente] {
        let requisicao = NSFetchRequest<ClienteEntity>(entityName: "ClienteEntity")
        do {
            let resposta = try container.viewContext.fetch(requisicao)
            var clientes: [Cliente] = []
            if !resposta.isEmpty {
                for clienteBD in resposta{
                    var cliente = Cliente(
                        id: clienteBD.id!,
                        nome: clienteBD.nome!,
                        telefone: clienteBD.telefone,
                        foto: clienteBD.foto
                    )
                    if clienteBD.medidas != nil{
                        let medidasDoCliente = try buscarTodasMedidasDoCliente(cliente: clienteBD)
                        cliente.medidas = medidasDoCliente
                    }
                    
//                    if clienteBD.pedidos != nil{
//                        let pedidosDoCliente = try buscarTodosPedidosDoCliente(idDoCliente: clienteBD.id!)
//                        cliente.pedidos = pedidosDoCliente
//                    }
                    clientes.append(cliente)
                }
            }
            return clientes
        } catch let error {
            print("erro ao buscar clientes \(error)")
        }
        return []
    }
    
    func buscarTodasMedidasDoCliente(cliente: ClienteEntity) throws -> [Medida] {
        let fetchRequest: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cliente == %@", cliente)
        do{
            let retorno = try container.viewContext.fetch(fetchRequest)
            var medidas: [Medida] = []
            
            if (!retorno.isEmpty){
                for medidaBD in retorno{
                    let medida = Medida(id: medidaBD.id!, descricao: medidaBD.descricao!, valor: medidaBD.valor)
                    medidas.append(medida)
                }
            }
            return medidas
        } catch let error {
            print("erro ao buscar medidas do cliente \(error)")
        }
        return []
    }

    
    
    
    func buscarClientePorId(idDoCliente: UUID) -> ClienteEntity? {
        // Buscar cliente existente no Core Data pelo ID (convertendo UUID para String)
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", idDoCliente.uuidString)
        
        do {
            let clientesExistentes = try container.viewContext.fetch(fetchRequest)
            
            if let clienteExistente = clientesExistentes.first {
                print("O CLIENTE EXISTE")
                return clienteExistente
            } else {
                print("O CLIENTE NAO EXISTE")
                return nil
            }
        } catch {
            print("Erro ao buscar cliente no Core Data: \(error)")
        }
        return nil
    }
    
    
    func deletarCliente(idDoCliente: UUID) {
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", idDoCliente.uuidString)
        
        do {
            let clientesExistentes = try container.viewContext.fetch(fetchRequest)
            
            if let clienteADeletar = clientesExistentes.first {
                // Se o cliente já existe, chama a função editarCliente
                container.viewContext.delete(clienteADeletar)
                salvar()
            }
        } catch {
            print("Erro ao buscar cliente no Core Data: \(error)")
        }
    }
    
    func deletarPedido(id: UUID) {
        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let pedidosExistentes = try container.viewContext.fetch(fetchRequest)
            
            if let pedidoADeletar = pedidosExistentes.first {
                // Se o cliente já existe, chama a função editarCliente
                container.viewContext.delete(pedidoADeletar)
                salvar()
            }
        } catch {
            print("Erro ao buscar cliente no Core Data: \(error)")
        }
    }
    
    
    func atualizar<Objeto>(entidade: NSManagedObject, objeto: Objeto) {
        let mirror = Mirror(reflecting: objeto)
        
        // Iterando sobre as propriedades do objeto
        for (nomePropriedade, valorPropriedade) in mirror.children {
            guard let nomePropriedade = nomePropriedade else { continue }
            entidade.setValue(valorPropriedade, forKey: nomePropriedade)
        }
        
        
        salvar()
        
    }
    
    func salvar() {
        do {
            try container.viewContext.save()
            
            
            
            
        } catch let error {
            print("Erro ao salvar no container: \(error)")
        }
    }
}

