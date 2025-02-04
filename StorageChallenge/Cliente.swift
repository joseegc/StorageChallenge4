import Foundation
import CoreData

struct Cliente: Identifiable {
    var id = UUID()
    var nome: String
    var telefone: String?
    var foto: Data?
    var pedidos: [Pedido]
    var medidas: [Medida]

init(id: UUID = UUID(), nome: String = "", telefone: String? = nil, foto: Data? = nil , pedidos: [Pedido] = [], medidas: [Medida] = []) {
        self.id = id
        self.nome = nome
        self.telefone = telefone
        self.foto = foto
        self.pedidos = pedidos
        self.medidas = medidas
    }

//    init(clienteEntity: ClienteEntity) {
//        self.id = clienteEntity.id!
//        self.nome = clienteEntity.nome!
//        self.telefone = clienteEntity.telefone
//        // Aqui você pode carregar a foto, se necessário
//        // self.foto = Foto(imagem: clienteEntity.imagem)
//
//        // Garantir que as relações sejam carregadas
//        let pedidosNSSet = clienteEntity.pedidos
//        print("Imprimindo NSSet de pedidos")
//        print(pedidosNSSet ?? "Não há pedidos")
//
//        if let pedidos = pedidosNSSet?.allObjects as? [Pedido] {
//            self.pedidos = pedidos
//        }
//
//        // Forçar o carregamento da relação de medidas
//        let medidasNSSet = clienteEntity.medidas
//        print("Imprimindo NSSet de medidas antes de forçar o carregamento")
//        print(medidasNSSet ?? "Não há medidas")
//
//        // Se o relacionamento de medidas estiver em fault, força o carregamento
//        if let context = clienteEntity.managedObjectContext {
//            context.performAndWait {
//                // Isso deve carregar a relação e evitar o fault
//                _ = medidasNSSet?.allObjects
//            }
//        }
//
//        // Agora, tente acessar novamente as medidas
//        if let medidas = medidasNSSet?.allObjects as? [Medida] {
//            self.medidas = medidas
//        } else {
//            print("Ainda não foi possível acessar as medidas.")
//        }
//    }


}
