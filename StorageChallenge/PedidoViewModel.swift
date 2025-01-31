//
//  PedidoViewModel.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import Foundation

var pedidosTeste = [Pedido(titulo: "titulo 1", statusDaEntrega: "Pendente", dataDeEntrega: Date(), cliente: Cliente(nome: "Cliente1"))]


class PedidoViewModel: ObservableObject{
    @Published var todosPedidos: [Pedido] = pedidosTeste
    @Published var pedido: Pedido? = nil
    @Published var cliente: Cliente? = pedidosTeste[0].cliente

    
}
