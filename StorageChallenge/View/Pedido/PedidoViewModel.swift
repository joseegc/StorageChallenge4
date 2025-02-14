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
    
    @Published var pedido: Pedido = Pedido()

    
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
    
    func editarPedido(){
        do {
            print("chamou deletar na viewModel")
            try bancoDeDados.editarPedido(pedido: pedido)
        } catch {
            print("Erro ao deletar cliente: \(error)")
        }
    }
    
    func buscarPedido(pedido: Pedido) -> Pedido? {
        do {
            return try bancoDeDados.buscarPedidoPorId(pedido: pedido)
        } catch {
            print("Erro ao busca cliente por ID: \(error)")
        }
        return nil
    }
    
    func salvarPedido() {
        
        do {
            try bancoDeDados.salvarPedido(pedido: self.pedido)
            
        } catch {
            print("Erro ao salvar clientes: \(error)")
        }
    }
    
    func deletarPedido(id: UUID) {
        
    }
    
    
    
}
