//
//  CardDeMedidasView.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 13/02/25.
//

import SwiftUI

struct CardDeMedidasComponent: View {
    var cliente: Cliente
    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack
            {
                Image("silhueta")
                
            }
            .padding(.horizontal, 20)
            
            
            
            
            VStack {
                if cliente.medidas.isEmpty {
                    VStack {
                        Spacer()
                        Text("Sem medidas cadastradas")
                            .foregroundStyle(Color.pretoFix)
                        
                        Spacer()
                    }
                }else {
                    ScrollView {
                        ForEach(cliente.medidas) { medida in
                            VStack(spacing: 0) {
                                HStack {
                                    Text("\(medida.descricao)")
                                        .frame(width: 90, alignment: .leading)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    
                                    
                                    
                                    Spacer()
                                    Text("\(String(format: "%.1f", medida.valor)) cm")
                                    
                                }
                                .font(.callout)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                
                                
                                
                                Rectangle()
                                    .frame(height: 0.5)
                                    .padding(.vertical, 12)
                                
                            }
                            .foregroundStyle(Color(.pretoFix))
                        }
                        .frame(maxWidth: .infinity)
                        
                        //                                    .scrollIndicators(.visible) // Garante que a barra de rolagem seja visível
                    }
                    .padding(24)
                    .scrollIndicators(.visible)
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.amarelo))
        }
        .frame(height: 269)
        .background(Color(.cinzaClaro))
        .clipShape(.rect(cornerRadius: 20))    }
}

#Preview {
    CardDeMedidasComponent(cliente: Cliente(medidas: [Medida(descricao: "Pescoço", valor: 39)]))
}
