//
//  MedidaComponent.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 14/02/25.
//

import SwiftUI

struct MedidaComponent: View {
    @Binding var medida: Medida
    var index: Int
    @Binding var medidasVazias: [Int]
    var clienteInput: Binding<[Medida]>
    var removerMedida: () -> Void
    var clientesViewModel: ClienteViewModel
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumIntegerDigits = 5
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                HStack {
                    if let index = clienteInput.wrappedValue.firstIndex(where: { $0.id == medida.id }) {

                        TextField("Exemplo: Busto", text: $medida.descricao)
                            .onChange(of: medida.descricao) { descricao in
                                if !descricao.isEmpty {
                                    medidasVazias.removeAll { $0 == index }
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
                        
                        TextField("Valor", value: $medida.valor, formatter: numberFormatter)
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
            
            Button(action: {
                if let index = clienteInput.wrappedValue.firstIndex(where: { $0.id == medida.id }) {
                    if medidasVazias.contains(index) {
                        medidasVazias.removeAll { $0 == index }
                    }
                    let idMedida = clienteInput.wrappedValue[index].id
                    clienteInput.wrappedValue.remove(at: index)
                    clientesViewModel.deletarMedida(id: idMedida)
                }
            }) {
                Image(systemName: "minus.circle")
                    .foregroundStyle(Color(.red))
            }
        }
        .padding(.bottom, 10)
    }
}

