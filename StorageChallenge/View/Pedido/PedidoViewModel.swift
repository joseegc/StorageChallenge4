//
//  PedidoViewModel.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import Foundation
import Combine

class PedidoViewModel: ObservableObject{
    private let bancoDeDados: BancoDeDados
    
    
    @Published var pedidos: [Pedido] = [] // Lista de pedidos
//    @Published var pedidoSelecionado: Pedido? // Pedido para visualização ou edição
    @Published var descricao: String = "" // Descrição para cadastro ou edição
    
    @Published var pedido:Pedido? = nil
    
    @Published var titulo = ""
    @Published var dataDeEntrega = Date()
    @Published var observacoes: String = ""
    @Published var status: String = "Pendente"
    @Published var valorPedido: String = ""
    
    init(bancoDeDados: BancoDeDados) {
        self.bancoDeDados = bancoDeDados
    }
    
//    func buscarPedidoPorId(id: UUID) {
////        self.pedido = CoreDataModel.shared.buscarPedidoPorId(id: id)
//    }
    
//    func buscarTodosOsPedidos() {
//        self.pedidos = pedidosTeste
//    }
//    
//    func buscarPedidosDoCliente(cliente: Cliente) {
//        self.pedidos = []
//        for pedido in pedidos {
//            if pedido.cliente.id == cliente.id {
//                self.pedidos.append(pedido)
//            }
//        }
//    }
    
//    func editarPedido(pedido: Pedido) {
//        self.pedidoSelecionado = pedido
//    }
    
    func salvarPedido(cliente: Cliente) {
        
        let pedido = Pedido(
            titulo: self.titulo,
            observacoes: self.observacoes, 
            dataDeEntrega: self.dataDeEntrega,
            cliente: cliente,
            statusPagamento: self.status
        )
        
        do {
            try bancoDeDados.salvarPedido(pedido: pedido)
        } catch {
            print("Erro ao salvar clientes: \(error)")
        }
    }
    
    func deletarPedido(id: UUID) {
        
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
