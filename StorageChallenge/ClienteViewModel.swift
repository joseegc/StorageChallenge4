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
    @ObservedObject var coreDataModel = CoreDataModel()  // Agora usa a instância compartilhada de CoreDataModel
    @Published var clientesSalvos: [ClienteEntity] = []

    @Published var cliente = Cliente()
    
    init(){

        clientesSalvos = coreDataModel.buscarClientes()
    }
    
   
    func adicionarAoBanco() {
        coreDataModel.adicionar(objeto: self.cliente)
        
        buscarClientesNoBanco()
    }
    
    func atualizarNoBanco(entidade: ClienteEntity) {
        self.cliente.nome += "!"
        coreDataModel.editarCliente(cliente: self.cliente, entidade: entidade)
    }
    
    func buscarClientesNoBanco() {
        self.clientesSalvos = coreDataModel.buscarClientes()
       
    }
    
    func deletarCliente(clienteADeletar: ClienteEntity) {
        coreDataModel.deletarCliente(clienteADeletar: clienteADeletar)
        buscarClientesNoBanco()
    }
    
    func deletarTodos() {
        self.clientesSalvos.removeAll()
    }
}
