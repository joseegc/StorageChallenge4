//
//  MedidaComponent.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 14/02/25.
//

import SwiftUI

struct MedidaInputComponent: View {
    @Binding var medida: Medida
    var onDelete: () -> Void
    @Binding var medidasVazias: [Int]
    @Binding var medidas: [Medida]

    var body: some View {
        HStack {
            VStack(spacing: 5) {
                HStack {
                    if let index = medidas.firstIndex(where: { $0.id == medida.id }) {
                        // TextField para Descrição
                        TextField("Exemplo: Busto", text: $medida.descricao)
                            .onChange(of: medida.descricao) { descricao in
                                if !descricao.isEmpty {
                                    if let indexToRemove = medidasVazias.firstIndex(of: index) {
                                        medidasVazias.remove(at: indexToRemove)
                                    }
                                }
                            }
                        
                        if medidasVazias.contains(index) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color("cinzaEscuro"))
                            .frame(width: 1)
                            .padding(.trailing, 10)
                        
                        TextField("Valor", value: $medida.valor, formatter: NumberFormatter())
                            .frame(width: 45)
                            .keyboardType(.decimalPad)
                        
                        Text("cm")
                            .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                    }
                }
                
                Rectangle()
                    .fill(Color("cinzaEscuro"))
                    .frame(height: 1)
            }
            
            // Botão de Remover Medida
            Button(action: onDelete) {
                Image(systemName: "minus.circle")
                    .foregroundStyle(Color(.red))
            }
        }
        .padding(.bottom, 10)
    }
}


//#Preview {
//    MedidaComponent()
//}
