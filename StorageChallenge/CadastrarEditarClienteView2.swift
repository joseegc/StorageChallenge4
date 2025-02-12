//
//  CadastrarEditarClienteView2.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 06/02/25.
//

import SwiftUI

struct CadastrarEditarClienteView2: View {
    @EnvironmentObject var viewModel: ClienteViewModel2
    
    @State var nome: String = ""
    @State var telefone: String = ""
    
    var body: some View {
        TextField("Nome", text: $nome)
        TextField("Telefone", text: $telefone)
        Button(action: {
            
            viewModel.savarCliente(cliente: Cliente(nome: self.nome, telefone: self.telefone))
        }) {
            Text("Salvar")
        }
    }
}

#Preview {
    CadastrarEditarClienteView2()
}
