//
//  CadastrarEditarPedidoView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 04/02/25.
//

import SwiftUI

struct CadastrarEditarPedidoView: View {
    @EnvironmentObject var viewModel: PedidoViewModel
    @State var cliente: Cliente
    
    var body: some View {
        VStack {
            Text("Informações do Pedido")
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Text("Título")
                    Spacer()
                }
                TextField("Título", text: $viewModel.titulo)
            }
            Divider()
            
            DatePicker(
                "Data de Entrega",
                selection: $viewModel.dataDeEntrega,
                displayedComponents: [.date]
            )
            Divider()
            VStack{
                HStack {
                    Text("Valor do pedido")
                    Spacer()
                }
                TextField("R$", text: $viewModel.valorPedido)
                    .onChange(of: viewModel.valorPedido) {
                        if viewModel.valorPedido == "R$"{
                            viewModel.valorPedido = ""
                        } else if viewModel.valorPedido != "" {
                            let novoValor = "R$" + "\(viewModel.valorPedido.replacingOccurrences(of: "R$", with: ""))"
                            viewModel.valorPedido = novoValor
                        }
                    }
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Status do Pagamento")
                
                Spacer()
                Picker("Selecione o status", selection: $viewModel.status) {
                    Text("Pendente").tag("Pendente")
                    Text("Pago").tag("Pago")
                }
                .pickerStyle(MenuPickerStyle())
            }
            Divider()
            
            VStack{
                HStack{
                    Text("Observações")
                    Spacer()
                }
                TextEditor(text: $viewModel.observacoes).frame(minHeight: 100).cornerRadius(8)
            }
        }.padding(.horizontal)
            .padding(.vertical , 25)
            .background(Color("cinzaClaro"))
            .cornerRadius(20)
        
        
            .navigationTitle("Cadastrar Pedido")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.salvarPedido(cliente: cliente)
                        print()
                    }, label: {
                        Text("Salvar")
                    })
                }
            }
            .padding(.horizontal, 21)
    }
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }
}

#Preview {
    NavigationStack{
        CadastrarEditarPedidoView(cliente: Cliente())
    }}
