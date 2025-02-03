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
                
                print("AAVWWEFBWEBGRTR")
                print(cliente.medidas?.count)
                var medidaEntity = verificarSeMedidaExiste(medida: medida)
                
                if medidaEntity == nil {
                    medidaEntity = MedidaEntity(context: CoreDataModel.shared.container.viewContext)
                    print("nova medida")
                }
                
                    medidaEntity?.descricao = medida.descricao
                    medidaEntity?.valor = medida.valor
                    medidaEntity?.cliente = clienteEntity
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
               
                return medidaExistente
            } else {
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
    
    //    func editarCliente(cliente: Cliente, entidade: ClienteEntity) {
    //        atualizarCliente(cliente: cliente, clienteEntity: entidade)
    //        salvar()
    //    }
    
    //
    //    func adicionarCliente(cliente: Cliente) {
    //        let novoClienteEntity = ClienteEntity(context: container.viewContext)
    //        atualizarCliente(cliente: cliente, clienteEntity: novoClienteEntity)
    //        salvar()
    //
    //    }
    
    //    func editarCliente(cliente: Cliente, entidade: ClienteEntity) {
    //        atualizarCliente(cliente: cliente, clienteEntity: entidade)
    //        salvar()
    //
    //    }
    //
    //    func deletarCliente(clienteADeletar: Cliente) {
    //        container.viewContext.delete(clienteADeletar)
    //        salvar()
    //    }
    //
    
    func deletarCliente(clienteADeletar: ClienteEntity) {
        
        
        container.viewContext.delete(clienteADeletar)
        
        salvar()
        
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

