import SwiftUI

struct MedidaComponent: View {
    @Binding var medida: Medida
    var index: Int
    @Binding var medidasVazias: [Int]
    var clienteInput: Binding<[Medida]>
    var removerMedida: () -> Void
    var clientesViewModel: ClienteViewModel

    @State private var valorTexto: String = ""

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

                        TextField("Valor", text: $valorTexto)
                            .frame(width: 60)
                            .keyboardType(.decimalPad)
                            .onChange(of: valorTexto) { novoValor in
                                let valorFormatado = formatarValor(novoValor)
                                valorTexto = valorFormatado

                                if let valorNumerico = Float(valorFormatado) {
                                    medida.valor = valorNumerico
                                }
                            }
                            .onSubmit {
                                if let valorNumerico = Float(valorTexto) {
                                    medida.valor = valorNumerico
                                } else {
                                    medida.valor = 0 // Se estiver vazio ou inválido, salva como 0
                                    valorTexto = ""
                                }
                            }

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
        .onAppear {
            valorTexto = medida.valor == 0 ? "" : String(format: "%.2f", medida.valor)
        }
    }

    func formatarValor(_ valor: String) -> String {
        let caracteresPermitidos = "0123456789.,"
        var filtrado = valor.filter { caracteresPermitidos.contains($0) }
        
        filtrado = filtrado.replacingOccurrences(of: ",", with: ".")

        if filtrado.filter({ $0 == "." }).count > 1 {
            filtrado.removeLast()
        }

        if let pontoIndex = filtrado.firstIndex(of: ".") {
            let inteiros = filtrado[..<pontoIndex]
            let decimais = filtrado[pontoIndex...]

            let inteirosLimitados = String(inteiros.prefix(4))

            let decimaisLimitados = String(decimais.prefix(3)) // Inclui o próprio ponto e 2 casas decimais

            filtrado = inteirosLimitados + decimaisLimitados
        } else {
            filtrado = String(filtrado.prefix(4))
        }

        return filtrado
    }

}

