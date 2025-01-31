//
//  Medida.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 31/01/25.
//

import Foundation

struct Medida: Identifiable {
    var id = UUID()
    var descricao: String
    var valor: Float
    
    
    init(descricao: String = "", valor: Float = 0) {
        self.descricao = descricao
        self.valor = valor
    }
}
