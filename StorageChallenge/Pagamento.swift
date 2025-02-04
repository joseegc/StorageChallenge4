//
//  Pagamento.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 31/01/25.
//

import Foundation

struct Pagamento: Identifiable {
    var id: UUID
    var statusDoPagamento: String
    var valor: Double
    
    init(id: UUID = UUID(), statusDoPagamento: String, valor: Double) {
        self.id = id
        self.statusDoPagamento = statusDoPagamento
        self.valor = valor
    }
}
