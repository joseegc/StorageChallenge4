//
//  SwiftDataImplementacao.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

import Foundation
import SwiftData
import SwiftUI

class SwiftDataModel: ObservableObject {
    // Usando @Query para buscar os dados
    @Query var clientes: [ClienteSwiftData]
    
    
    init() {
        let cliente = ClienteSwiftData(nome: "Jorge", telefone: "Carlitos")
    }
    
    func buscarClientes() -> [ClienteSwiftData] {
        return clientes
    }
    

    
    // Método para atualizar algum dado, se necessário
//    func updatePedido(pedido: Pedido, novoNome: String) {
//        pedido.nome = novoNome
//    }
}
