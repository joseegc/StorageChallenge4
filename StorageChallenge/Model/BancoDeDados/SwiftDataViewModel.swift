

import Foundation
import SwiftUI


class SwiftDataViewModel: ObservableObject {
    @Published var clientes: [Cliente] = []
    
    @Published var cliente = Cliente(id: UUID(),nome: "Antonio", telefone: "(11) 98078-9146", pedidos: [Pedido(titulo: "Vestido", statusDaEntrega: "Completo", observacoes: "Braco gigantesco", dataDeEntrega: Date(), cliente: Cliente(nome: "Antonio"))], medidas:[])
    
    init(){
        
      
        buscarTodosClientes()
    }
    
    
//    func adicionarClienteAoBanco() {
//        print(self.cliente)
//        do {
//            try CoreDataModel.shared.salvarCliente(cliente: self.cliente)
//        } catch {
//            print("erro ao salvar")
//        }
//        buscarTodosClientes()
//    }
//    
//    func editarCliente() {
//        do {
//            try CoreDataModel.shared.editarCliente(cliente: self.cliente)
//        } catch {
//            print("erro ao salvar")
//        }
//        buscarTodosClientes()
//    }
    
    func buscarTodosClientes() {
        
//        self.clientes =
    }
//    func buscarClientePorId(idDoCliente: UUID) -> Cliente {
//        var cliente = Cliente()
//        if let clienteBuscado = CoreDataModel.shared.buscarClientePorId(idDoCliente: idDoCliente) {
//            cliente.id = clienteBuscado.id!
//            
//            
//            cliente.nome = clienteBuscado.nome ?? ""
//            
//            cliente.telefone = clienteBuscado.telefone ?? ""
//            
//            if let imagemSalva = clienteBuscado.foto {
//                cliente.foto = imagemSalva
//            }
//            
//            
//            if let medidasSalvas = clienteBuscado.medidas?.allObjects as? [MedidaEntity] {
//                for medida in medidasSalvas {
//                    let medida = Medida(id: medida.id!, descricao: medida.descricao ?? "", valor: medida.valor)
//                    cliente.medidas.append(medida)
//                }
//                
//            }
//            
//            //            if let pedidosSalvos = clienteBuscado.pedidos?.allObjects as? [PedidoEntity] {
//            //                for pedido in pedidosSalvos {
//            //                    let pedido = Medida(id: medida.id!, descricao: medida.descricao ?? "", valor: medida.valor)
//            //                    self.cliente.medidas?.append(medida)
//            //                }
//            //
//            //            }
//        }
//        return cliente
//    }
//    
//    func buscarClientePorNome(nome: String) {
//        do {
//            self.clientes = try CoreDataModel.shared.buscarClientesPorNome(nome: nome)
//            
//        } catch {
//            print("erro ao buscar")
//        }
//    }
//    
//    func deletarCliente(idDoCliente: UUID) {
//        print("deletando cliente de id \(idDoCliente)")
//        CoreDataModel.shared.deletarCliente(idDoCliente: idDoCliente)
//        buscarTodosClientes()
//    }
//    
//    func deletarMedida(id: UUID) {
//        do {
//            print("fala")
//           try CoreDataModel.shared.deletarMedida(id: id)
//            
//        } catch {
//            print("erro ao deletar medida")
//        }    }
//    
//    func deletarTodos() {
//        self.clientes.removeAll()
//    }
}
