//
//  ClienteEntity+CoreDataProperties.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 03/02/25.
//
//

import Foundation
import CoreData


extension ClienteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClienteEntity> {
        return NSFetchRequest<ClienteEntity>(entityName: "ClienteEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var nome: String?
    @NSManaged public var telefone: String?
    @NSManaged public var foto: FotoEntity?
    @NSManaged public var medidas: NSSet?
    @NSManaged public var pedidos: NSSet?

    
}

// MARK: Generated accessors for medidas
extension ClienteEntity {

    @objc(addMedidasObject:)
    @NSManaged public func addToMedidas(_ value: MedidaEntity)

    @objc(removeMedidasObject:)
    @NSManaged public func removeFromMedidas(_ value: MedidaEntity)

    @objc(addMedidas:)
    @NSManaged public func addToMedidas(_ values: NSSet)

    @objc(removeMedidas:)
    @NSManaged public func removeFromMedidas(_ values: NSSet)

}

// MARK: Generated accessors for pedidos
extension ClienteEntity {

    @objc(addPedidosObject:)
    @NSManaged public func addToPedidos(_ value: PedidoEntity)

    @objc(removePedidosObject:)
    @NSManaged public func removeFromPedidos(_ value: PedidoEntity)

    @objc(addPedidos:)
    @NSManaged public func addToPedidos(_ values: NSSet)

    @objc(removePedidos:)
    @NSManaged public func removeFromPedidos(_ values: NSSet)

}

extension ClienteEntity : Identifiable {

}
