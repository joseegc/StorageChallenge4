//
//  CardDeClienteComponent.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 13/02/25.
//

import SwiftUI

struct CardDeClienteComponent: View {
    var cliente: Cliente
    var body: some View {
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
                        .frame(width: 200, alignment: .leading)

                        .fontWeight(.medium)
                        .font(.title2)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    
                        Text(cliente.telefone)
                        .frame(width: 180, alignment: .leading)
                        .font(.title3)

                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(Color.preto32)

            .padding(20)
                .background(.amarelo)
                .cornerRadius(8).foregroundColor(Color.accentColor)
           
            
        }    }
}

#Preview {
    CardDeClienteComponent(cliente: Cliente(nome: "Sabrina de Oliveira Batista", telefone: "(11) 98078-9146", medidas: [Medida(descricao: "Pescoço", valor: 39)]))
}
