//
//  Pagamento.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 31/01/25.
//

import Foundation

struct Pagamento {
    var statusDoPagamento: String
    var valor: Double
    
    init(statusDoPagamento: String, valor: Double) {
        self.statusDoPagamento = statusDoPagamento
        self.valor = valor
    }
}
