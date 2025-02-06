//
//  PedidoViewModel.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import Foundation
import Combine

var pedidosTeste = [Pedido(titulo: "titulo 1", statusDaEntrega: "Pendente", dataDeEntrega: Date(), cliente: Cliente(nome: "Cliente1")), Pedido(titulo: "titulo 1", statusDaEntrega: "Pendente", dataDeEntrega: Date(), cliente: Cliente(nome: "Cliente1")), Pedido(titulo: "titulo 1", statusDaEntrega: "Pendente", dataDeEntrega: Date(), cliente: Cliente(nome: "Cliente1"))]



class PedidoViewModel: ObservableObject{
    @Published var pedidos: [Pedido] = pedidosTeste
    @Published var pedido: Pedido?

    init() {
        buscarTodosOsPedidos()
    }
    
    func buscarTodosOsPedidos() {
        
        self.pedidos = pedidosTeste
    }
    
    func buscarPedidoPorId(id: UUID) {
//        self.pedido = CoreDataModel.shared.buscarPedidoPorId(id: id)
    }
    
    
    
    func buscarPedidosDoCliente(cliente: Cliente) {
        self.pedidos = []
        for pedido in pedidos {
            if pedido.cliente.id == cliente.id {
                self.pedidos.append(pedido)
            }
        }
    }
    
    
    func deletarPedido(id: UUID) {
        CoreDataModel.shared.deletarPedido(id: id)
        buscarTodosOsPedidos()
    }
    
    
    
}


//class PedidoViewModel: ObservableObject {
//    @Published var pedidos: [Pedido] = [] // Lista de pedidos
//    @Published var pedidosDoCliente: [Pedido] = [] // Lista de pedidos de um cliente especifico
//    @Published var pedidoSelecionado: Pedido? // Pedido para visualização ou edição
//    @Published var descricao: String = "" // Descrição para cadastro ou edição
//

//    // Função para salvar pedido (novo ou editado)
//    func savePedido(cliente: Cliente) -> Pedido {
//        let pedido = Pedido(id: pedidoSelecionado?.id ?? Int.random(in: 1...1000),
//                            descricao: descricao, cliente: cliente)
//        
//        if let index = pedidos.firstIndex(where: { $0.id == pedido.id }) {
//            pedidos[index] = pedido // Atualiza o pedido existente
//        } else {
//            pedidos.append(pedido) // Adiciona um novo pedido
//        }
//        
//        return pedido
//    }
//    
//    // Função para apagar pedido
//    func deletePedido(id: Int) {
//        pedidos.removeAll { $0.id == id }
//    }
//}
