//
//  ClienteViewModel.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import Foundation
import CoreData
import SwiftUI


class ClienteViewModel: ObservableObject {
    @Published var clientesSalvos: [ClienteEntity] = []
    @Published var clientes: [Cliente] = []

    @Published var cliente = Cliente(id: UUID(),nome: "Antonio", telefone: "(11) 98078-9146", pedidos: [Pedido(titulo: "Vestido", statusDaEntrega: "Completo", observacoes: "Braco gigantesco", dataDeEntrega: Date(), cliente: Cliente(nome: "Antonio"))], medidas:[Medida(descricao: "Corpo", valor: 15), Medida(descricao: "Rosto", valor: 99)])
    
    init(){
        
        do {
            try self.clientes = CoreDataModel.shared.buscarTodosClientes()
        } catch {
            print("erro ao salvar")
        }
        buscarClientesNoBanco()
    }
    
    
    func adicionarClienteAoBanco() {
        print(self.cliente)
        do {
            try CoreDataModel.shared.salvarCliente(cliente: self.cliente)
        } catch {
            print("erro ao salvar")
        }
        buscarClientesNoBanco()
        buscarTodosClientes()
    }
    
    func editarCliente() {
        do {
            try CoreDataModel.shared.editarCliente(cliente: self.cliente)
        } catch {
            print("erro ao salvar")
        }
        buscarClientesNoBanco()
        buscarTodosClientes()
    }
    
    //    func atualizarNoBanco(entidade: ClienteEntity) {
    //        self.cliente.nome += "!"
    //        CoreDataModel.shared.editarCliente(cliente: self.cliente, entidade: entidade)
    //    }
    //
    func buscarClientesNoBanco() {
        //        self.clientesSalvos = CoreDataModel.shared.buscarClientes()
        let novosClientes = CoreDataModel.shared.buscarClientes()
        self.clientesSalvos = novosClientes  //
        
    }
    
    func buscarTodosClientes() {
        
        do {
                self.clientes = try CoreDataModel.shared.buscarTodosClientes()
            
        } catch {
            print("erro ao buscar")
        }
    }
    func buscarClientePorId(idDoCliente: UUID) -> Cliente {
        var cliente = Cliente()
        if let clienteBuscado = CoreDataModel.shared.buscarClientePorId(idDoCliente: idDoCliente) {
            cliente.id = clienteBuscado.id!
            
            
            cliente.nome = clienteBuscado.nome ?? ""
            
            cliente.telefone = clienteBuscado.telefone ?? ""
            
            if let imagemSalva = clienteBuscado.foto {
                cliente.foto = imagemSalva
            }
            
            
            if let medidasSalvas = clienteBuscado.medidas?.allObjects as? [MedidaEntity] {
                for medida in medidasSalvas {
                    let medida = Medida(id: medida.id!, descricao: medida.descricao ?? "", valor: medida.valor)
                    cliente.medidas.append(medida)
                }
                
            }
            
            //            if let pedidosSalvos = clienteBuscado.pedidos?.allObjects as? [PedidoEntity] {
            //                for pedido in pedidosSalvos {
            //                    let pedido = Medida(id: medida.id!, descricao: medida.descricao ?? "", valor: medida.valor)
            //                    self.cliente.medidas?.append(medida)
            //                }
            //
            //            }
        }
        return cliente
    }
    
    func deletarCliente(idDoCliente: UUID) {
        print("deletando cliente de id \(idDoCliente)")
        CoreDataModel.shared.deletarCliente(idDoCliente: idDoCliente)
        buscarClientesNoBanco()
    }
    
    func deletarTodos() {
        self.clientesSalvos.removeAll()
    }
}
