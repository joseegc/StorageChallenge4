//
//  ClienteCoreData.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

import CoreData

@objc(PedidoEntity)
public class PedidoCoreData: NSManagedObject {
    
    @NSManaged public var id: UUID?
    @NSManaged public var titulo: String?
    @NSManaged public var statusDaEntrega: String?
    @NSManaged public var dataDeEntrega: Date?
    @NSManaged public var observacoes: String?
    @NSManaged public var cliente: ClienteEntity?
    @NSManaged public var medidas: Set<MedidaEntity>?
    @NSManaged public var pagamento: PagamentoEntity?
    @NSManaged public var referencias: Set<FotoEntity>?
    
    
    // Função para criar uma ClienteEntity a partir de um Cliente
    convenience init(pedido: Pedido, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "PedidoEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.id = pedido.id
        self.titulo = pedido.titulo
        self.statusDaEntrega = pedido.statusDaEntrega
        self.dataDeEntrega = pedido.dataDeEntrega
        
        let clienteEntity = ClienteCoreData(cliente: pedido.cliente, context: context)
        self.cliente = clienteEntity
        
        // Assumindo que pedidos são um array de Pedido structs
        self.pedidos = Set(cliente.pedidos?.map { pedido -> PedidoEntity in
            let pedidoEntity = PedidoEntity(context: context)
            pedidoEntity.id = pedido.id
            pedidoEntity.titulo = pedido.titulo
            pedidoEntity.statusDaEntrega = pedido.statusDaEntrega
            pedidoEntity.dataDeEntrega = pedido.dataDeEntrega
            pedidoEntity.cliente = self
            pedidoEntity.observacoes = pedido.observacoes
            
            pedidoEntity.medidas = Set(pedido.medidas?.map{ medida -> MedidaEntity in
                let medidaEntity = MedidaEntity(context: context)
                medidaEntity.id = medida.id
                medidaEntity.descricao = medida.descricao
                medidaEntity.valor = medida.valor
                medidaEntity.pedido = pedidoEntity
                
                return medidaEntity
                
            } ?? [])
            
            pedidoEntity.referencias = Set(pedido.referencias?.map{ imagem -> ReferenciaEntity in
                let referenciaEntity = ReferenciaEntity(context: context)
                referenciaEntity.id = imagem.id
                referenciaEntity.imagem = imagem.descricao
                referenciaEntity.pedido = pedidoEntity
                
                return referenciaEntity
                
            } ?? [])
            
            if let pagamento = pedido.pagamento {
                let pagamentoEntity = PagamentoEntity(context: context)
                pagamentoEntity.id = pagamento.id
                pagamentoEntity.statusDoPagamento = pagamento.statusDoPagamento
                pagamentoEntity.valor = pagamento.valor
                pagamentoEntity.pedido = pedidoEntity  // Relacionando pagamento ao pedido
                pedidoEntity.pagamento = pagamentoEntity  // Associando ao pedido
            }
            
            return pedidoEntity
        } ?? [])
        
        
    }
}
