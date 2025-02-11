//
//  MedidaSwiftData.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 11/02/25.
//

import Foundation
import SwiftData

@Model
final class MedidaSwiftData: Identifiable {
    var id: UUID
    var descricao: String
    var valor: Float
    var cliente: ClienteSwiftData?
    
    
    init(id: UUID = UUID(), descricao: String = "", valor: Float = 0) {
        self.id = id
        self.descricao = descricao
        self.valor = valor
    }
}
