//
//  ClienteViewModel2.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 06/02/25.
//

import Foundation

class ClienteViewModel2: ObservableObject {
    private let bancoDeDados: BancoDeDados
    
    @Published var clientes: [Cliente] = []
    
    @Published var cliente: Cliente = Cliente()
    
    init(bancoDeDados: BancoDeDados) {
        self.bancoDeDados = bancoDeDados
        carregarClientes()
    }
    
    
    func carregarClientes() {
        do {
            clientes = try bancoDeDados.buscarTodosClientes()
        } catch {
            print("Erro ao carregar clientes: \(error)")
        }
    }
    
    func deletarCliente(idDoCliente: UUID) {
        do {
            print("chamou deletar na viewModel")
            try bancoDeDados.deletarCliente(id: idDoCliente)
        } catch {
            print("Erro ao deletar cliente: \(error)")
        }
    }
    
    func buscarClientePorId(id: UUID) {
        do {
            cliente = try bancoDeDados.buscarClientePorId(idDoCliente: id)
        } catch {
            print("Erro ao deletar cliente: \(error)")
        }
    }
    
    func editarCliente(){
        do {
            print("chamou deletar na viewModel")
            try bancoDeDados.editarCliente(cliente: cliente)
        } catch {
            print("Erro ao deletar cliente: \(error)")
        }
    }
}
