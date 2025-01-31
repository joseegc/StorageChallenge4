//
//  CadastrarClienteViewModel.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import Foundation
import CoreData
import SwiftUI


class CadastrarEditarClienteViewModel: ObservableObject {
    @ObservedObject var coreDataModel = CoreDataModel()  // Agora usa a instância compartilhada de CoreDataModel

    @Published var clientesSalvos: [ClienteEntity] = []

    @Published var cliente = Cliente(nome: "nome1")
    
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
   
    
    func deletarTodos() {
        self.clientesSalvos.removeAll()
    }
}
