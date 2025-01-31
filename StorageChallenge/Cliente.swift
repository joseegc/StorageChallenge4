//
//  Cliente.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import Foundation

struct Cliente {
    var id = UUID()
    var nome: String
    var idade: Int
    
    init(nome: String, idade: Int) {
        self.nome = nome
        self.idade = idade
    }
}
