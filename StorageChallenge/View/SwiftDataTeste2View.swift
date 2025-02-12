//
//  SwiftDataTeste2View.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 12/02/25.
//

import SwiftUI
import SwiftData

struct SwiftDataTeste2View: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var swiftDataModel = SwiftDataModel()

    @Query var clientes: [ClienteSwiftData]
    var body: some View {
        Button {
            adicionarCliente(cliente: Cliente(nome: "Jorge"))
        } label: {
            Text("Add")
        }

        ForEach(clientes) { cliente in
            Text(cliente.nome)
                .onTapGesture {
                    SwiftDataModel.shared.deletarCliente(cliente: cliente)
                }
        }
    }
    
    func adicionarCliente(cliente: Cliente) {
        let clienteAdicionado = ClienteSwiftData()
        clienteAdicionado.nome = cliente.nome
        
        modelContext.insert(clienteAdicionado)
    }
}

#Preview {
    SwiftDataTeste2View()
        .modelContainer(for: ClienteSwiftData.self, inMemory: true)

}
