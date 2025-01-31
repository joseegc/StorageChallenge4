//
//  ClienteViewModel.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import Foundation
import CoreData


class ClienteViewModel: ObservableObject {
    var coreDataModel = CoreDataModel()
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
    
    func deletarCliente(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        coreDataModel.deletarCliente(cliente: clientesSalvos[index])
        buscarClientesNoBanco()
    }
    
    func deletarTodos() {
        self.clientesSalvos.removeAll()
    }
}
