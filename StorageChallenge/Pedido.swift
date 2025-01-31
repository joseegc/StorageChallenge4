//
//  Pedido.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 31/01/25.
//

import Foundation

struct Pedido {
    var id = UUID()
    var titulo : String
    var statusDaEntrega: String
    var observacoes: String?
    var dataDeEntrega: Date
    var cliente: Cliente
    var medidas: [Medida]?
    var pagamento: Pagamento?
    var referencias: [Foto]?
    
    init(id: UUID = UUID(), titulo: String, statusDaEntrega: String, observacoes: String? = nil, dataDeEntrega: Date, cliente: Cliente, medidas: [Medida]? = nil, pagamento: Pagamento? = nil, referencias: [Foto]? = nil) {
        self.id = id
        self.titulo = titulo
        self.statusDaEntrega = statusDaEntrega
        self.observacoes = observacoes
        self.dataDeEntrega = dataDeEntrega
        self.cliente = cliente
        self.medidas = medidas
        self.pagamento = pagamento
        self.referencias = referencias
    }
}
