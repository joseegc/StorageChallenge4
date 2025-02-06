//
//  Pedido.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 31/01/25.
//

import Foundation

struct Pedido: Identifiable {
    var id = UUID()
    var titulo : String
    var statusDaEntrega: String
    var observacoes: String?
    var dataDeEntrega: Date
    var cliente: Cliente
    var referencias: [Foto]? = []
    
    
    init(id: UUID = UUID(), titulo: String = "", statusDaEntrega: String = "Pendente", observacoes: String? = nil, dataDeEntrega: Date = Date(), cliente: Cliente = Cliente(), referencias: [Foto]? = []) {
        self.id = id
        self.titulo = titulo
        self.statusDaEntrega = statusDaEntrega
        self.observacoes = observacoes
        self.dataDeEntrega = dataDeEntrega
        self.cliente = cliente
        self.referencias = referencias
    }
    
    
}
