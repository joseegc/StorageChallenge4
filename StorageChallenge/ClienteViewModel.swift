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

    @Published var cliente = Cliente(id: UUID(),nome: "Antonio", pedidos: [Pedido(titulo: "Vestido", statusDaEntrega: "Completo", observacoes: "Braco gigantesco", dataDeEntrega: Date(), cliente: Cliente(nome: "Antonio"))], medidas:[Medida(descricao: "Corpo", valor: 15), Medida(descricao: "Rosto", valor: 99)])
    
    init(){

        clientesSalvos = CoreDataModel.shared.buscarClientes()
    }
    
   
    func adicionarClienteAoBanco() {
        print(self.cliente)
        CoreDataModel.shared.adicionarCliente(cliente: self.cliente)
        
        buscarClientesNoBanco()
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
    
    func buscarClientePorId(idDoCliente: UUID) {
        if let clienteBuscado = CoreDataModel.shared.buscarClientePorId(idDoCliente: idDoCliente) {
            self.cliente.id = clienteBuscado.id!
            
            
            self.cliente.nome = clienteBuscado.nome ?? ""
            
            self.cliente.telefone = clienteBuscado.telefone ?? ""
            
            if let imagemSalva = clienteBuscado.foto {
                self.cliente.foto = imagemSalva
            }
            
            
            if let medidasSalvas = clienteBuscado.medidas?.allObjects as? [MedidaEntity] {
                for medida in medidasSalvas {
                    let medida = Medida(id: medida.id!, descricao: medida.descricao ?? "", valor: medida.valor)
                    self.cliente.medidas?.append(medida)
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
    }
    
    func deletarCliente(idDoCliente: UUID) {
        CoreDataModel.shared.deletarCliente(idDoCliente: idDoCliente)
        buscarClientesNoBanco()
    }
    
    func deletarTodos() {
        self.clientesSalvos.removeAll()
    }
}
