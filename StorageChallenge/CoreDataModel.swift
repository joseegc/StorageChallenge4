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
        
        if objeto is ClienteEntity {
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
        
        func criarCliente(cliente: ClienteEntity) {
            let context = container.viewContext
            
            // Verificar se o cliente já existe no banco
            let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
            
            guard let clienteId = cliente.id else {
                print("ID do cliente é inválido.")
                return
            }
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", clienteId.uuidString)
            
            do {
                let clienteEntities = try context.fetch(fetchRequest)
                
                // Se não encontrar o cliente, criar um novo
                if clienteEntities.isEmpty {
                    let clienteEntity = ClienteEntity(context: context)
                    clienteEntity.id = cliente.id
                    clienteEntity.nome = cliente.nome
                    clienteEntity.telefone = cliente.telefone
                    
                    // Criar a foto, se houver
                    if let clienteFoto = cliente.foto {
                        let fotoEntity = FotoEntity(context: context)
                        fotoEntity.imagem = clienteFoto.imagem
                        clienteEntity.foto = fotoEntity
                    }
                    
                    // Criar as medidas, se houver
                    if let medidas = cliente.medidas {
                        for medida in medidas {
                            if let medida = medida as? Medida {
                                let medidaEntity = MedidaEntity(context: context)
                                medidaEntity.descricao = medida.descricao
                                medidaEntity.valor = medida.valor
                                medidaEntity.cliente = clienteEntity
                            } else {
                                print("Medida inválida: \(medida)")
                            }
                        }
                    }
                    
                    // Salvar o cliente no contexto
                    try context.save()
                    
                } else {
                    atualizarCliente(cliente: cliente)
                    print("Cliente com id \(cliente.id) já existe no banco de dados.")
                }
                
            } catch {
                print("Erro ao criar o cliente: \(error.localizedDescription)")
            }
        }

      
        func atualizarCliente(cliente: ClienteEntity) {
            let context = container.viewContext
            
            // 1. Verificar se já existe um cliente com o mesmo id
            let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
            
            // Desembrulhando o UUID e convertendo para string
            guard let clienteId = cliente.id else {
                print("ID do cliente é inválido.")
                return
            }
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", clienteId.uuidString)
            
            do {
                let clienteEntities = try context.fetch(fetchRequest)
                
                if let clienteExistente = clienteEntities.first {
                    // 2. Caso exista, sobrescrever os dados
                    clienteExistente.nome = cliente.nome
                    clienteExistente.telefone = cliente.telefone
                    
                    // Atualizar a foto se houver
                    if let clienteFoto = cliente.foto {
                        if let fotoExistente = clienteExistente.foto {
                            fotoExistente.imagem = clienteFoto.imagem
                        } else {
                            let fotoEntity = FotoEntity(context: context)
                            fotoEntity.imagem = clienteFoto.imagem
                            clienteExistente.foto = fotoEntity
                        }
                    }
                    
                    // Atualizar as medidas se houver
                    if let medidas = cliente.medidas {
                        // Primeiro apagamos as medidas antigas
                        clienteExistente.removeFromMedidas(clienteExistente.medidas ?? [])
                        
                        // Loop pelas medidas, garantindo que o tipo seja correto
                        for medida in medidas {
                            // AQUI FAZEMOS O DOWNCAST PARA 'Medida'
                            if let medida = medida as? Medida {
                                let medidaEntity = MedidaEntity(context: context)
                                medidaEntity.descricao = medida.descricao
                                medidaEntity.valor = medida.valor
                                medidaEntity.cliente = clienteExistente
                            } else {
                                print("Medida inválida: \(medida)")
                            }
                        }
                    }
                    
                } else {
                    // 3. Caso não exista, cria um novo cliente
                    let clienteEntity = ClienteEntity(context: context)
                    clienteEntity.id = cliente.id
                    clienteEntity.nome = cliente.nome
                    clienteEntity.telefone = cliente.telefone
                    
                    if let clienteFoto = cliente.foto {
                        let fotoEntity = FotoEntity(context: context)
                        fotoEntity.imagem = clienteFoto.imagem
                        clienteEntity.foto = fotoEntity
                    }
                    
                    if let medidas = cliente.medidas {
                        for medida in medidas {
                            if let medida = medida as? Medida {
                                let medidaEntity = MedidaEntity(context: context)
                                medidaEntity.descricao = medida.descricao
                                medidaEntity.valor = medida.valor
                                medidaEntity.cliente = clienteEntity
                            } else {
                                print("Medida inválida: \(medida)")
                            }
                        }
                    }
                }
                
                // 4. Salvar as mudanças no contexto
               salvar()
                
            } catch {
                print("Erro ao atualizar o cliente: \(error.localizedDescription)")
            }
        }

        
    
    
//    func atualizarCliente(clienteEntity: ClienteEntity) {
//        clienteEntity.id = cliente.id
//        clienteEntity.nome = cliente.nome
//        clienteEntity.telefone = cliente.telefone
//        
//        if let clienteFoto = cliente.foto {
//            let fotoEntity = FotoEntity(context: container.viewContext)
//            fotoEntity.imagem = clienteFoto.imagem
//            clienteEntity.foto = fotoEntity
//        }
//        if let medidas = cliente.medidas {
//            for medida in cliente.medidas ?? [] {
//                    let medidaEntity = MedidaEntity(context: CoreDataModel.shared.container.viewContext)
//                    medidaEntity.descricao = medida.descricao
//                    medidaEntity.valor = medida.valor
//                medidaEntity.cliente = clienteEntity
//                }
//        }
////        if let pedidos = cliente.pedidos {
////            clienteEntity.pedidos = NSSet(array: pedidos)
////        }
//            
    }
    
//    func adicionarCliente(cliente: Cliente) {
//        let novoClienteEntity = ClienteEntity(context: container.viewContext)
//        atualizarCliente(cliente: cliente, clienteEntity: novoClienteEntity)
//        salvar()
//        
//    }
//    
//    func editarCliente(cliente: Cliente, entidade: ClienteEntity) {
//        atualizarCliente(cliente: cliente, clienteEntity: entidade)
//        salvar()
//        
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

