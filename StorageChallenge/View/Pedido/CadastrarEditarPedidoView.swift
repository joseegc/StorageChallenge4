//
//  CadastrarEditarPedidoView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 04/02/25.
//

import SwiftUI

struct CadastrarEditarPedidoView: View {
    @EnvironmentObject var pedidoViewModel: PedidoViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var cliente: Cliente?
    var idDoPedido: UUID?
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumIntegerDigits = 4
        return formatter
    }()
    
    @State private var amount: String = ""

      // Formatter para valores monetários (R$)
      private let currencyFormatter: NumberFormatter = {
          let formatter = NumberFormatter()
          formatter.numberStyle = .currency
          formatter.currencySymbol = "R$"
          formatter.locale = Locale(identifier: "pt_BR")
          return formatter
      }()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Informações do Produto")
                
                VStack {VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Título", text: $pedidoViewModel.pedido.titulo)
                        Rectangle()
                            .fill(Color("cinzaEscuro"))
                            .frame(height: 1)
                        
                    }
                    
                    HStack{
                        Text("Cliente")
                        
                        Spacer()
                    }
                    
                    HStack {
                        NavigationLink(destination: SelecionarClienteView()) {
                            Text("Selecionar Cliente")
                            
                        }
                        Spacer()
                    }
                    
                    HStack{
                        Text("Data de Entrega")
                        
                        Spacer()
                    }
                    
                  
                    
                    DatePicker(
                        "Data",
                        selection: $pedidoViewModel.pedido.dataDeEntrega,
                        displayedComponents: [.date] // Você pode usar .hourAndMinute para selecionar hora e minuto também
                    )
                    .datePickerStyle(WheelDatePickerStyle()) // Para mostrar o seletor no estilo de roda
                    .padding()
                    
                    HStack {
                        Text("Status do Pagamento")
                        Spacer()
                    }
                    
                    
                    Picker("Pagamento", selection: $pedidoViewModel.pedido.pagamento.statusDoPagamento) {
                        Text("Pendente").tag("Pendente")
                        Text("Pago").tag("Pago")
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Aplica o estilo segmentado
                    
                    HStack {
                        Text("Valor")
                        Spacer()
                    }
                    TextField("0,00", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: amount) { newValue in
                                        // Remover caracteres não numéricos
                                        let cleanString = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                                        
                                        // Converter a string limpa para um número
                                        if let value = Double(cleanString) {
                                            let formattedValue = currencyFormatter.string(from: NSNumber(value: value / 100)) ?? "R$ 0,00"
                                            amount = formattedValue
                                        } else {
                                            amount = ""
                                        }
                                    }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   
                    
                    HStack {
                        Text("Status do Pedido")
                        Spacer()
                    }
                    Picker("Status", selection: $pedidoViewModel.pedido.statusDaEntrega) {
                        Text("Pendente").tag("Pendente")
                        Text("Em Andamento").tag("Em Andamento")
                        Text("Finalizado").tag("Finalizado")
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Aplica o estilo segmentado
                    
                    HStack {
                        Text("Medidas do Pedido")
                        Spacer()
                    }
                    
                    ForEach(pedidoViewModel.pedido.medidas ?? [], id: \.id) { medida in
                        VStack(spacing: 5) {
                            HStack {
                                // TextField para Descricao
                                TextField("Descriçao", text: Binding(
                                    get: { medida.descricao },
                                    set: { newValue in
                                        // Encontra o índice de 'medida' e atualiza sua descrição
                                        if let index = pedidoViewModel.pedido.medidas.firstIndex(where: { $0.id == medida.id }) {
                                            pedidoViewModel.pedido.medidas[index].descricao = newValue
                                        }
                                    }
                                ))
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    // TextField para Valor (número)
                                    Rectangle()
                                        .fill(Color("cinzaEscuro"))
                                        .frame(width: 1)
                                        .padding(.trailing, 10)
                                    
                                    TextField("Valor", value: Binding(
                                        get: { medida.valor },
                                        set: { newValue in
                                            // Encontra o índice de 'medida' e atualiza seu valor
                                            if let index = pedidoViewModel.pedido.medidas.firstIndex(where: { $0.id == medida.id }) {
                                                pedidoViewModel.pedido.medidas[index].valor = newValue
                                            }
                                        }
                                    ), formatter: numberFormatter)
                                    .frame(width: 45)
                                    
                                    
                                    Text("cm").padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                                    
                                }
                            }
                            
                            Text("Observações")
                        }
                    }
                    
                    
                    
                    
                    
                    Button(action: {
                        pedidoViewModel.pedido.medidas.append(Medida())
                    }, label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(Color("preto"))
                            Text("Adicionar Medida")
                                .font(.system(size: 13))
                                .foregroundStyle(Color("preto"))
                        }.padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                    }).background(Color(.white)).cornerRadius(20)
                    
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.vertical , 53)
                .background(Color("cinzaClaro"))
                .cornerRadius(20)
                }
                

            }
            .navigationTitle(idDoPedido != nil ? "Editar Pedido" : "Cadastrar Pedido")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        print()
                    }, label: {
                        Text("Salvar")
                    })
                }
            }
            .task {
                if idDoPedido != nil {
                    pedidoViewModel.buscarPedidoPorId(id: idDoPedido!)
                    
                } else {
                    pedidoViewModel.pedido = Pedido()
                }
                
            }
        }
        .padding(.horizontal, 21)
       

    }
}

#Preview {
    CadastrarEditarPedidoView()
        .environmentObject(PedidoViewModel())
}
