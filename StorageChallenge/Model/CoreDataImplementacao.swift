//
//  CoreDataImplementacao.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

import CoreData

class CoreDataImplementacao: BancoDeDados {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "AppContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Erro ao buscar o container \(error)")
            }
        }
    }
    
    func salvarPedido(pedido: Pedido) throws {
        <#function body#>
    }
    
    
    func salvar<T>(item: T) throws {
        let context = container.viewContext
        
        if let cliente = item as? Cliente {
            let clienteEntity = ClienteEntity(context: context)
            clienteEntity.id = cliente.id
            clienteEntity.nome = cliente.nome
            clienteEntity.telefone = cliente.telefone
            
            // Para pedidos, você pode iterar sobre o array de pedidos e adicionar ao cliente
            if let pedidos = cliente.pedidos {
                for pedido in pedidos {
                    let pedidoEntity = PedidoEntity(context: context)
                    pedidoEntity.id = pedido.id
                    pedidoEntity.titulo = pedido.titulo
                    pedidoEntity.statusDeEntrega = pedido.statusDaEntrega
                    pedidoEntity.dataDeEntrega = pedido.dataDeEntrega
                    pedidoEntity.observacoes = pedido.observacoes
                    
                    if let medidas = pedido.medidas {
                        for medida in medidas {
                            let medidaEntity = MedidaEntity(context: context)
//                            medidaEntity.id = medida.id
                            medidaEntity.descricao = medida.descricao
                            medidaEntity.valor = medida.valor
                            medidaEntity.cliente = clienteEntity
                        }
                    }
                    
                    
                    
                    
                    
                    
                    clienteEntity.addToPedidos(pedidoEntity) // Assumindo que você tem um relacionamento entre Cliente e Pedido
                }
            }
            
            // Salvar o contexto
            
        } else if let pedido = item as? Pedido {
            let pedidoEntity = PedidoEntity(context: context)
            
            
        }
        
        try context.save()
        // Adicionar outros tipos de objetos, como Pedido ou Medida, conforme necessário
    }

    
    func editar<T>(item: T) throws {
        <#code#>
    }
    
    func deletar<T>(item: T) throws {
        <#code#>
    }
    
    func buscarTodos<T>() throws -> [T] {
        <#code#>
    }
    
    func buscarPorId<T>(id: String) throws -> T? {
        <#code#>
    }
    
}
