//
//  BancoDeDados.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 03/02/25.
//

import Foundation


protocol BancoDeDados {
    func salvarCliente(cliente: Cliente) throws
    func salvarPedido(pedido: Pedido) throws
    func salvarMedida(medida: Medida) throws
    func salvarReferencia(imagem: Data) throws
    func salvarInfoPagamento(dadosPagamento: (statusPagamento: String, valor: Double)) throws
    
    func buscarTodosClientes() throws -> [Cliente]
    func buscarTodosPedidos() throws -> [Pedido]
    func buscarTodasMedidas<T>(id: UUID, entity: T) throws -> [Medida]
    func buscarTodasReferencias(id: UUID) throws -> [Foto]
    
    func buscarPorIdClientes(id: UUID) throws -> Cliente
    func buscarPorIdPedidos(id: UUID) throws -> Pedido
    
    func deletarCliente(id: UUID) throws
    func deletarPedido(id: UUID) throws
    func deletarMedida(id: UUID) throws
    func deletarReferencia(id: UUID) throws

}
