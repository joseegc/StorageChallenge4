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
            print("erro ao buscar clientes")
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

    
    func adicionarCliente(cliente: Cliente) {
      let novoCliente = ClienteEntity(context: container.viewContext)
        novoCliente.nome = cliente.nome
        
        novoCliente.idade = Int64(cliente.idade)
        salvar()
        
    }
    
    func deletarCliente(cliente: ClienteEntity) {
        container.viewContext.delete(cliente)
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
            
            
            buscarClientes()
            
            
        } catch let error {
            print("Erro ao salvar no container: \(error)")
        }
    }
}

