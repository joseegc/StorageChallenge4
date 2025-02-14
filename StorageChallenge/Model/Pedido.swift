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
    var observacoes: String?
    var dataDeEntrega: Date
    var cliente: Cliente
    var statusPagamento: String
    
    
    init(id: UUID = UUID(), titulo: String, observacoes: String? = "", dataDeEntrega: Date, cliente: Cliente = Cliente(), statusPagamento: String) {
        self.id = id
        self.titulo = titulo
        self.observacoes = observacoes
        self.dataDeEntrega = dataDeEntrega
        self.cliente = cliente
        self.statusPagamento = statusPagamento
    }
}
