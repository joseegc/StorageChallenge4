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

    @Published var cliente = Cliente()
    
    init(){

        clientesSalvos = CoreDataModel.shared.buscarClientes()
    }
    
   
    func adicionarAoBanco() {
        CoreDataModel.shared.adicionar(objeto: self.cliente)
        
        buscarClientesNoBanco()
    }
    
    func atualizarNoBanco(entidade: NSManagedObject) {
        self.cliente.nome += "!"
        CoreDataModel.shared.atualizar(entidade: entidade, objeto: self.cliente)
    }
    
    func buscarClientesNoBanco() {
        self.clientesSalvos = CoreDataModel.shared.buscarClientes()
       
    }
    
    func deletarCliente(clienteADeletar: ClienteEntity) {
        CoreDataModel.shared.deletarCliente(clienteADeletar: clienteADeletar)
        buscarClientesNoBanco()
    }
    
    func deletarTodos() {
        self.clientesSalvos.removeAll()
    }
}
