//
//  ClienteViewModel2.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 06/02/25.
//

import Foundation

class ClienteViewModel: ObservableObject {
    private let bancoDeDados: BancoDeDados
    
    @Published var clientes: [Cliente] = []
    
    @Published var cliente: Cliente = Cliente()
    
    init(bancoDeDados: BancoDeDados) {
        self.bancoDeDados = bancoDeDados
//        carregarClientes()
    }
    
    func salvarCliente() {
        do {
            try bancoDeDados.salvarCliente(cliente: self.cliente)
        } catch {
            print("Erro ao salvar clientes: \(error)")
        }
    }
    
    func buscarClientePorId(id: UUID) -> Cliente?
    {
        do {
            return try bancoDeDados.buscarClientePorId(id: id)
        } catch {
            print("Erro ao busca cliente por ID: \(error)")
        }
        return nil
    }
    
    
    func buscarTodosClientes() {
        do {
            self.clientes = try bancoDeDados.buscarTodosClientes()
        } catch {
            print("Erro ao carregar clientes: \(error)")
        }
    }
    

    
    func buscarClientesPorNome(nome: String) {
        do {
            self.clientes = try bancoDeDados.buscarClientesPorNome(nome: nome)
            
        } catch {
            print("erro ao buscar")
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
    
//    func buscarClientePorId(id: UUID) {
//        do {
//            cliente = try bancoDeDados.buscarClientePorId(idDoCliente: id)
//        } catch {
//            print("Erro ao deletar cliente: \(error)")
//        }
//    }
    
    func editarCliente(){
        do {
            print("chamou deletar na viewModel")
            try bancoDeDados.editarCliente(cliente: cliente)
        } catch {
            print("Erro ao deletar cliente: \(error)")
        }
    }
    func deletarMedida(id: UUID){
        do {
            print("chamou deletar na viewModel")
            try bancoDeDados.deletarMedida(id: id)
        } catch {
            print("Erro ao deletar cliente: \(error)")
        }
    }
}
