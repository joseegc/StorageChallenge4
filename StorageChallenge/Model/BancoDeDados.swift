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
    
    
    
    
    func editar<T>(item: T) throws
    func deletar<T>(item: T) throws
    func buscarTodos<T>() throws -> [T]
    func buscarPorId<T>(id: String) throws -> T?
}
