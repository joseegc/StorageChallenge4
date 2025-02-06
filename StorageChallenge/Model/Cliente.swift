import Foundation

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
}
