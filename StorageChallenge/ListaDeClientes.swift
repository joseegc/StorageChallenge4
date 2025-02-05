//
//  ListaDeClientes.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 05/02/25.
//

import SwiftUI

var clientesTeset = [Cliente(nome: "Teste 0"), Cliente(nome: "Teste 1"), Cliente(nome: "Teste 2")]

struct ListaDeClientes: View {
    @State var clientes: [Cliente] = []
    var body: some View {
        if clientes.isEmpty {
            Text("Não há nenhum cliente cadastrado")
        } else{
            VStack(spacing: 20){
                ForEach(clientes){ cliente in
                    NavigationLink(destination: ListarPedidosView()){
                        HStack(spacing:10){
                            if let imageData = cliente.foto, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                            else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                            VStack{
                                Text(cliente.nome)
                                    .font(.title2)
                                if let telefone = cliente.telefone {
                                    Text(telefone).font(.title3)
                                }
                            }
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }.padding(20)
                            .background(.amarelo)
                            .cornerRadius(8).foregroundColor(Color.accentColor)
                        
                    }.padding(.horizontal, 20)
                }
            }
            Spacer()
                .navigationTitle("Clientes")
                .toolbar {
                            // Botão de adicionar na parte superior direita
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: ListarPedidosView()) {
                                    Image(systemName: "plus")
                                        .fontWeight(.black)
                                }
                            }
                        }
        }
    }
}

#Preview {
    NavigationStack{
        ListaDeClientes(clientes: clientesTeset)
    }
    
}
