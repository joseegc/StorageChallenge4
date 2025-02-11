//
//  Pedido.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 31/01/25.
//

import Foundation
import SwiftData

@Model
final class PedidoSwiftData: Identifiable {
    var id = UUID()
    var titulo : String
    var statusDaEntrega: String
    var observacoes: String?
    var dataDeEntrega: Date
    var cliente: ClienteSwiftData
    var referencias: [FotoSwiftData]?
    
    
    init(id: UUID = UUID(), titulo: String = "", statusDaEntrega: String = "Pendente", observacoes: String? = nil, dataDeEntrega: Date = Date(), cliente: ClienteSwiftData = ClienteSwiftData(), referencias: [FotoSwiftData]? = nil) {
        self.id = id
        self.titulo = titulo
        self.statusDaEntrega = statusDaEntrega
        self.observacoes = observacoes
        self.dataDeEntrega = dataDeEntrega
        self.cliente = cliente
        self.referencias = referencias
    }
}
