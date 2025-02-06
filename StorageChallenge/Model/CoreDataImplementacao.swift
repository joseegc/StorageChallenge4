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
    
    func buscarClientePorId(idDoCliente: UUID) throws -> Cliente {
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", idDoCliente.uuidString)
        var cliente: Cliente = Cliente()
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            if let clienteBD = retorno.first {
                cliente = Cliente(id: clienteBD.id!, nome: clienteBD.nome!, telefone: clienteBD.telefone!)
                if clienteBD.pedidos != nil {
                    let pedidos = try buscarTodosPedidos(idDoCliente: clienteBD.id!)
                    cliente.pedidos = pedidos
                }
            }
        } catch {
            print("Erro ao buscar cliente por id no Core Data: \(error)")
        }
        return cliente
    }
    
    func salvarCliente(cliente: Cliente) throws {
        let novoCliente = ClienteEntity(context: container.viewContext)
        novoCliente.id = cliente.id
        novoCliente.nome = cliente.nome
        novoCliente.telefone = cliente.telefone
        novoCliente.foto = cliente.foto
        
        for medida in cliente.medidas  {
            try salvarMedidaAoCliente(medida: medida, cliente: cliente)
        }
    }
    
    func salvarMedidaAoCliente(medida: Medida, cliente: Cliente) throws{
        let novaMedida = MedidaEntity(context: container.viewContext)
        novaMedida.id = medida.id
        novaMedida.descricao = medida.descricao
        novaMedida.valor = medida.valor
        
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cliente.id.uuidString)
        
        do{
            let retorno = try container.viewContext.fetch(fetchRequest)
            let clienteBD = retorno.first
            novaMedida.cliente = clienteBD
            
            try container.viewContext.save()
        } catch{
            print("Erro ao salvar medida do cliente no Core Data: \(error)")
        }
    }
    
    func editarCliente(cliente: Cliente) throws{
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cliente.id.uuidString)
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            let clienteBD = retorno.first
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
            let medidaBD = retornoMedida.first
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
        var clientes: [Cliente] = []
        do {
            let resposta = try container.viewContext.fetch(requisicao)
            
            if !resposta.isEmpty {
                for clienteBD in resposta{
                    var cliente = Cliente(
                        id: clienteBD.id!,
                        nome: clienteBD.nome!,
                        telefone: clienteBD.telefone,
                        foto: clienteBD.foto
                    )
                    if clienteBD.medidas != nil{
                        let fetchRequestMedida: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
                        fetchRequestMedida.predicate = NSPredicate(format: "cliente == %@", clienteBD)
                        
                        let retornoMedidas = try container.viewContext.fetch(fetchRequestMedida)
                        if (!retornoMedidas.isEmpty){
                            for medidaBD in retornoMedidas{
                                let medida = Medida(id: medidaBD.id!, descricao: medidaBD.descricao!, valor: medidaBD.valor)
                                cliente.medidas.append(medida)
                            }
                        }
                    }
                    
                    if clienteBD.pedidos != nil{
                        let pedidosDoCliente = try buscarTodosPedidos(idDoCliente: clienteBD.id!)
                        cliente.pedidos = pedidosDoCliente
                    }
                    clientes.append(cliente)
                }
                
            }
        } catch let error {
            print("erro ao buscar clientes \(error)")
        }
        for cliente in clientes {
            print(cliente.id)
        }
        return clientes
    }
    
    func deletarCliente(id: UUID) throws {
        
        print("chamou deletar no core data \(id)")
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            print("retornou essa quantidade de clientes \(retorno.count)")
            if let clienteADeletar = retorno.first {
                // Se o cliente já existe, chama a função editarCliente
                
                container.viewContext.delete(clienteADeletar)
                try container.viewContext.save()
            }
        } catch {
            print("Erro ao deletar cliente no Core Data: \(error)")
        }
    }
    
    func deletarMedida(id: UUID) throws {
        let fetchRequest: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            if let medidaADeletar = retorno.first {
                // Se o cliente já existe, chama a função editarCliente
                container.viewContext.delete(medidaADeletar)
                try container.viewContext.save()
            }
        } catch {
            print("Erro ao deletar medida no Core Data: \(error)")
        }
    }
    
    func buscarTodosPedidos(idDoCliente: UUID?) throws -> [Pedido] {
        let requisicao = NSFetchRequest<PedidoEntity>(entityName: "PedidoEntity")
        
        if idDoCliente != nil {
            let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", idDoCliente!.uuidString)
            let retorno = try container.viewContext.fetch(fetchRequest)
            let cliente = retorno.first
            
            requisicao.predicate = NSPredicate(format: "cliente == %@", cliente!)
        }
        
        var pedidos: [Pedido] = []
        do {
            let resposta = try container.viewContext.fetch(requisicao)
            
            if !resposta.isEmpty {
                for pedidoBD in resposta{
                    var pedido = Pedido(
                        id: pedidoBD.id!,
                        titulo: pedidoBD.titulo!,
                        statusDaEntrega: pedidoBD.statusDeEntrega!,
                        observacoes: pedidoBD.observacoes,
                        dataDeEntrega: pedidoBD.dataDeEntrega!
                    )
                    if pedidoBD.referencias != nil {
                        let fetchRequestReferencia: NSFetchRequest<ReferenciaEntity> = ReferenciaEntity.fetchRequest()
                        fetchRequestReferencia.predicate = NSPredicate(format: "pedido == %@", pedidoBD)
                        
                        let retornoReferencia = try container.viewContext.fetch(fetchRequestReferencia)
                        
                        if retornoReferencia.isEmpty{
                            for referencia in retornoReferencia{
                                let referencia = Foto(imagem: referencia.imagem!)
                                pedido.referencias?.append(referencia)
                            }
                        }
                        
                    }
                }
            }
        } catch let error {
            print("erro ao buscar pedidos \(error)")
        }
        return pedidos
    }
    
    func buscarPedidoPorId(idDoPedido: UUID) throws -> Pedido {
        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", idDoPedido.uuidString)
        var pedido: Pedido = Pedido()
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            if let pedidoBD = retorno.first {
                pedido = Pedido(id: pedidoBD.id!,
                                    titulo: pedidoBD.titulo!,
                                    statusDaEntrega: pedidoBD.statusDeEntrega!,
                                    observacoes: pedidoBD.observacoes,
                                    dataDeEntrega: pedidoBD.dataDeEntrega!
                                    )
                
                if pedidoBD.referencias != nil {
                    let fetchRequestReferencia: NSFetchRequest<ReferenciaEntity> = ReferenciaEntity.fetchRequest()
                    fetchRequestReferencia.predicate = NSPredicate(format: "pedido == %@", pedidoBD)
                    
                    let retornoReferencia = try container.viewContext.fetch(fetchRequestReferencia)
                    
                    if retornoReferencia.isEmpty{
                        for referencia in retornoReferencia{
                            let referencia = Foto(imagem: referencia.imagem!)
                            pedido.referencias?.append(referencia)
                        }
                    }
                    
                }
                return pedido
            }
        } catch {
            print("Erro ao buscar cliente por id no Core Data: \(error)")
        }
        return pedido
    }
    
    func salvarPedido(pedido: Pedido, cliente: Cliente) throws{
        let novoPedido = PedidoEntity(context: container.viewContext)
        novoPedido.id = pedido.id
        novoPedido.titulo = pedido.titulo
        novoPedido.dataDeEntrega = pedido.dataDeEntrega
        novoPedido.statusDeEntrega = pedido.statusDaEntrega
        novoPedido.observacoes = pedido.observacoes
        
        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cliente.id.uuidString)
        
        do{
            let retorno = try container.viewContext.fetch(fetchRequest)
            let clienteBD = retorno.first
            novoPedido.cliente = clienteBD
            
            try container.viewContext.save()
        } catch{
            print("Erro ao salvar medida no Core Data: \(error)")
        }
    }
    
    func editarPedido(pedido: Pedido) throws{
        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", pedido.id.uuidString)
        
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            var pedidoBD = retorno.first
            if pedidoBD?.titulo != pedido.titulo {
                pedidoBD?.titulo = pedido.titulo
            }
            
            if pedidoBD?.dataDeEntrega != pedido.dataDeEntrega {
                pedidoBD?.dataDeEntrega = pedido.dataDeEntrega
            }
            
            if pedidoBD?.statusDeEntrega != pedido.statusDaEntrega {
                pedidoBD?.dataDeEntrega = pedido.dataDeEntrega
            }
            
            if pedidoBD?.observacoes != pedido.observacoes {
                pedidoBD?.observacoes = pedido.observacoes
            }
            
            try container.viewContext.save()
            
        } catch {
            print("Erro ao editar cliente no Core Data: \(error)")
        }
        
    }
    
    func deletarPedido(id: UUID) throws {
        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            if let pedidoADeletar = retorno.first {
                // Se o cliente já existe, chama a função editarCliente
                container.viewContext.delete(pedidoADeletar)
                try container.viewContext.save()
            }
        } catch {
            print("Erro ao deletar pedido no Core Data: \(error)")
        }
    }
    
    func salvarReferencia(imagem: Data, pedido: Pedido) throws{
        let novaReferencia = ReferenciaEntity(context: container.viewContext)
        novaReferencia.imagem = imagem
        
        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", pedido.id.uuidString)
        
        do{
            let retorno = try container.viewContext.fetch(fetchRequest)
            let pedidoBD = retorno.first
            novaReferencia.pedido = pedidoBD
            
            try container.viewContext.save()
        } catch{
            print("Erro ao salvar referencia no Core Data: \(error)")
        }
    }
    
    func deletarReferencia(id: UUID) throws {
        let fetchRequest: NSFetchRequest<ReferenciaEntity> = ReferenciaEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let retorno = try container.viewContext.fetch(fetchRequest)
            
            if let referenciaADeletar = retorno.first {
                // Se o cliente já existe, chama a função editarCliente
                container.viewContext.delete(referenciaADeletar)
                try container.viewContext.save()
            }
        } catch {
            print("Erro ao deletar referencia no Core Data: \(error)")
        }
    }
    
    
    
    
    
//    func deletarMedida(id: UUID) throws {
//        
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func salvarMedidaAoPedido(medida: Medida, pedido: Pedido) throws {
//        let novaMedida = MedidaEntity(context: container.viewContext)
//        novaMedida.id = medida.id
//        novaMedida.descricao = medida.descricao
//        novaMedida.valor = medida.valor
//        
//        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", pedido.id.uuidString)
//        
//        do{
//            let retorno = try container.viewContext.fetch(fetchRequest)
//            let pedidoBD = retorno.first
//            novaMedida.pedido = pedidoBD
//            
//            try container.viewContext.save()
//        } catch{
//            print("Erro ao salvar medida do pedido no Core Data: \(error)")
//        }
//    }
    
    
    
    
//    func salvarInfoPagamento(dadosPagamento: (statusPagamento: String, valor: Double), pedido: Pedido) throws {
//        let novaInfoDePagamento = PagamentoEntity(context: container.viewContext)
//        novaInfoDePagamento.statusDoPagamento = dadosPagamento.statusPagamento
//        novaInfoDePagamento.valor = dadosPagamento.valor
//        
//        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", pedido.id.uuidString)
//        
//        do{
//            let retorno = try container.viewContext.fetch(fetchRequest)
//            let pedidoBD = retorno.first
//            novaInfoDePagamento.pedido = pedidoBD
//            
//            try container.viewContext.save()
//        } catch{
//            print("Erro ao salvar pagamento no Core Data: \(error)")
//        }
//    }
    
    
    
    
    
    
//    func editarMedidaDoPedido(medida: Medida, pedido: Pedido) throws {
//        let fetchRequestMedida: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
//        fetchRequestMedida.predicate = NSPredicate(format: "id == %@", medida.id.uuidString)
//        do{
//            let retornoMedida = try container.viewContext.fetch(fetchRequestMedida)
//            var medidaBD = retornoMedida.first
//            if medidaBD == nil {
//                try salvarMedidaAoPedido(medida: medida, pedido: pedido)
//            } else {
//                if medidaBD?.descricao != medida.descricao {
//                    medidaBD?.descricao = medida.descricao
//                }
//                if medidaBD?.valor != medida.valor {
//                    medidaBD?.valor = medida.valor
//                }
//                try container.viewContext.save()
//            }
//        } catch {
//            print("Erro ao editar medida no Core Data: \(error)")
//        }
//    }
    
    
//    func editarInfoPagamento(pagamento: Pagamento, pedidoBD: PedidoEntity) throws{
//        let fetchRequest: NSFetchRequest<PagamentoEntity> = PagamentoEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "pedido == %@", pedidoBD)
//        do {
//            let retorno = try container.viewContext.fetch(fetchRequest)
//            
//            if retorno.isEmpty {
//                print("Nenhum pagamento encontrado para o pedido")
//            } else {
//                let pagamento = retorno.first
//                
//                if pagamento?.statusDoPagamento != pagamento?.statusDoPagamento{
//                    pagamento?.statusDoPagamento = pagamento?.statusDoPagamento ?? "Pendente"
//                }
//                
//                if pagamento?.valor != pagamento?.valor{
//                    pagamento?.valor = pagamento?.valor ?? 0
//                }
//                
//                try container.viewContext.save()
//            }
//        } catch {
//            print("Erro ao buscar pagamentos: \(error)")
//        }
//        
//        
//    }
    
//    func buscarTodasMedidasDoPedido(pedido: PedidoEntity) throws -> [Medida] {
//        let fetchRequest: NSFetchRequest<MedidaEntity> = MedidaEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "pedido == %@", pedido)
//        do{
//            let retorno = try container.viewContext.fetch(fetchRequest)
//            var medidas: [Medida] = []
//            
//            if (!retorno.isEmpty){
//                for medidaBD in retorno{
//                    let medida = Medida(id: medidaBD.id!, descricao: medidaBD.descricao!, valor: medidaBD.valor)
//                    medidas.append(medida)
//                }
//            }
//            return medidas
//        } catch let error {
//            print("erro ao buscar medidas do cliente \(error)")
//        }
//        return []
//    }
    
//    func buscarTodosPedidosDoCliente(idDoCliente: UUID) throws -> [Pedido] {
////        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
////        fetchRequest.predicate = NSPredicate(format: "id == %@", idDoCliente)
////        let fetchRequest: NSFetchRequest<PedidoEntity> = PedidoEntity.fetchRequest()
////        fetchRequest.predicate = NSPredicate(format: "cliente == %@", pedido)
////        do{
////            let retorno = try container.viewContext.fetch(fetchRequest)
////            var medidas: [Medida] = []
////
////            if (!retorno.isEmpty){
////                for medidaBD in retorno{
////                    let medida = Medida(id: medidaBD.id!, descricao: medidaBD.descricao!, valor: medidaBD.valor)
////                    medidas.append(medida)
////                }
////            }
////            return medidas
////        } catch let error {
////            print("erro ao buscar medidas do cliente \(error)")
////        }
//        return[]
//    }
    
//    func buscarPorIdClientes(id: UUID) throws -> Cliente? {
//        let fetchRequest: NSFetchRequest<ClienteEntity> = ClienteEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
//        
//        do {
//            let retorno = try container.viewContext.fetch(fetchRequest)
//            
//            if let retorno = retorno.first {
//                let cliente = Cliente(
//                    id: retorno.id!,
//                    nome: retorno.nome!,
//                    telefone: retorno.telefone,
//                    foto: retorno.foto
//                )
//            } else {
//                
//            }
//        } catch {
//            print("Erro ao buscar cliente no Core Data: \(error)")
//        }
//        return nil
//    }
//    func buscarPorIdPedidos(id: UUID) throws -> Pedido? {
//        return nil
//    }
    

    
//    func deletarPedido(id: UUID) throws {
//        
//    }
//    func deletarReferencia(id: UUID) throws {
//        
//    }
    
}
