//
//  ClienteSwiftData.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 11/02/25.
//

import Foundation
import SwiftData

@Model
class ClienteSwiftData {
    var id = UUID()
    var nome: String
    var telefone: String?
    var foto: Data?
    var pedidos: [PedidoSwiftData]
    var medidas: [MedidaSwiftData]
    
    init(id: UUID = UUID(), nome: String = "", telefone: String? = nil, foto: Data? = nil , pedidos: [PedidoSwiftData] = [], medidas: [MedidaSwiftData] = []) {
        self.id = id
        self.nome = nome
        self.telefone = telefone
        self.foto = foto
        self.pedidos = pedidos
        self.medidas = medidas
    }
}
