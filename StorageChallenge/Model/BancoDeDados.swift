//
//  BancoDeDados.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

import Foundation


protocol BancoDeDados {
    func salvarCliente(cliente: Cliente) throws
    func salvarMedidaAoCliente(medida: Medida, cliente: Cliente) throws
    func editarCliente(cliente: Cliente) throws
    func buscarTodosClientes() throws -> [Cliente]
    func deletarCliente(id: UUID) throws
    
    
    
    
    
//    func salvarPedido(pedido: Pedido, cliente: Cliente) throws
//    func salvarMedidaAoPedido(medida: Medida, pedido: Pedido) throws
//
//    func salvarReferencia(imagem: Data, pedido: Pedido) throws
//    func salvarInfoPagamento(dadosPagamento: (statusPagamento: String, valor: Double), pedido: Pedido) throws
//    
//    func editarPedido(pedido: Pedido) throws
//    func editarMedidaDoCliente(medida: Medida, cliente: Cliente) throws
//    func editarMedidaDoPedido(medida: Medida, pedido: Pedido) throws
//    func editarInfoPagamento(pagamento: Pagamento, pedidoBD: PedidoEntity) throws
//    
//    
//    func buscarTodosPedidosDoCliente(idDoCliente: UUID) throws -> [Pedido]
//    func buscarTodosPedidos() throws -> [Pedido]
////    func buscarTodasMedidasDoCliente(idDoCliente: UUID) throws -> [Medida]
////    func buscarTodasMedidasDoPedido(idDoPedido: UUID) throws -> [Medida]
//    func buscarTodasReferencias(idDoPedido: UUID) throws -> [Foto?]
//    
//    func buscarPorIdClientes(id: UUID) throws -> Cliente?
//    func buscarPorIdPedidos(id: UUID) throws -> Pedido?
//    
//    
//    func deletarPedido(id: UUID) throws
//    func deletarMedida(id: UUID) throws
//    func deletarReferencia(id: UUID) throws

}
