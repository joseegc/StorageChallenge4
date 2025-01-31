//
//  ClientesView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI


struct ListarClientesView: View {
    @StateObject var clientesViewModel = ClienteViewModel()
    
    var body: some View {
        VStack {
            Text(clientesViewModel.cliente.nome)
            Text("Cadastrar Cliente")
            TextField("nome", text: $clientesViewModel.cliente.nome)
            TextField("idade", value: $clientesViewModel.cliente.idade, formatter: NumberFormatter())
                .keyboardType(.numberPad)
            
            Button(action: {
                clientesViewModel.adicionarAoBanco()
            }, label: {
                Text("Enviar")
                    .frame(width: 200, height: 50)
                    .background(.blue)
                    .foregroundStyle(Color(.white))
            })
            
            
            List {
                ForEach(clientesViewModel.clientesSalvos, id: \.self) { cliente in
                    Text(cliente.nome ?? "Sem nome")
                        .onTapGesture {
                            clientesViewModel.atualizarNoBanco(entidade: cliente)
                        }
                }.onDelete(perform: clientesViewModel.deletarCliente)
            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    ListarClientesView(clientesViewModel: ClienteViewModel())
}
