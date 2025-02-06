//
//  ListaDeClientes.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 05/02/25.
//

import SwiftUI

struct ListaDeClientesView: View {
    @EnvironmentObject var viewModel: ClienteViewModel
    
    var body: some View {
        VStack(spacing: 20){
            if viewModel.clientes.isEmpty {
                Text("Não há nenhum cliente cadastrado")
            } else{
                ForEach(viewModel.clientes){ cliente in
                    NavigationLink(destination: PerfilDoClienteView(cliente: cliente)){
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
                            VStack(alignment: .leading){
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
                    }
                }
                Spacer()
            }
        }.padding(20)
            .navigationTitle("Clientes")
            .background(Color(.corDeFundo))
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CadastrarEditarClienteView()) {
                        Image(systemName: "plus")
                            .fontWeight(.black)
                    }
                }
            }
            .onAppear{
                viewModel.buscarTodosClientes()
            }
    }
}


#Preview {
    NavigationStack{
        ListaDeClientesView()
            .environmentObject(ClienteViewModel())
    }
    
}
