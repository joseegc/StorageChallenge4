//
//  ClienteCoreData.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

import CoreData

@objc(ClienteEntity)
public class ClienteCoreData: NSManagedObject {
    
    @NSManaged public var id: UUID?
    @NSManaged public var nome: String?
    @NSManaged public var telefone: String?
    @NSManaged public var foto: Data?
    @NSManaged public var pedidos: Set<PedidoEntity>?
    @NSManaged public var medidas: Set<MedidaEntity>?
    
    // Função para criar uma ClienteEntity a partir de um Cliente
    convenience init(cliente: Cliente, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "ClienteEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.id = cliente.id
        self.nome = cliente.nome
        self.telefone = cliente.telefone
        
        // Agora, ao invés de self (que é ClienteCoreData), usamos diretamente a ClienteEntity
        self.pedidos = Set(cliente.pedidos?.map { pedido -> PedidoEntity in
            let pedidoEntity = PedidoEntity(context: context)
            pedidoEntity.id = pedido.id
            pedidoEntity.titulo = pedido.titulo
            pedidoEntity.statusDeEntrega = pedido.statusDaEntrega
            pedidoEntity.dataDeEntrega = pedido.dataDeEntrega
            if let clienteEntity = self as? ClienteEntity {
                            pedidoEntity.cliente = clienteEntity
                        }
            pedidoEntity.observacoes = pedido.observacoes
            
            pedidoEntity.medidas = Set(pedido.medidas?.map { medida -> MedidaEntity in
                let medidaEntity = MedidaEntity(context: context)
//                medidaEntity.id = medida.id
                medidaEntity.descricao = medida.descricao
                medidaEntity.valor = medida.valor
                medidaEntity.pedido = pedidoEntity
                return medidaEntity
            } ?? []) as NSSet
            
            pedidoEntity.referencias = Set(pedido.referencias?.map { imagem -> FotoEntity in
                let referenciaEntity = FotoEntity(context: context)
//                referenciaEntity.id = imagem.id
                referenciaEntity.imagem = imagem.imagem
                referenciaEntity.pedido = pedidoEntity
                return referenciaEntity
            } ?? []) as NSSet
            
            if let pagamento = pedido.pagamento {
                let pagamentoEntity = PagamentoEntity(context: context)
//                pagamentoEntity.id = pagamento.id
                pagamentoEntity.statusDoPagamento = pagamento.statusDoPagamento
                pagamentoEntity.valor = pagamento.valor
                pagamentoEntity.pedido = pedidoEntity  // Relacionando pagamento ao pedido
                pedidoEntity.pagamento = pagamentoEntity // Associando ao pedido
            }
            
            return pedidoEntity
        } ?? [])
    }
}
