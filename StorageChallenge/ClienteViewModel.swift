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

    @Published var cliente = Cliente(nome: "", telefone: "")
    
    init(){
        clientesSalvos = coreDataModel.buscarClientes()
    }
    
   
    func adicionarAoBanco() {
        coreDataModel.adicionar(objeto: self.cliente)
        
        buscarClientesNoBanco()
    }
    
    func atualizarNoBanco(entidade: NSManagedObject) {
        self.cliente.nome += "!"
        coreDataModel.atualizar(entidade: entidade, objeto: self.cliente)
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
