//
//  CadastrarEditarPedidoView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 04/02/25.
//

import SwiftUI

struct CadastrarEditarPedidoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: PedidoViewModel
    @State var cliente: Cliente
    
    @State var titulo = ""
    @State var dataDeEntrega = Date()
    @State var observacoes: String = ""
    @State var statusPagamento: String = "Pendente"
    @State var valorPedido: String = ""
    var idDoPedido: UUID?
    
    var body: some View {
        VStack {
            Text("Informações do Pedido")
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Text("Título")
                    Spacer()
                }
                TextField("Título", text: $titulo)
            }
            Divider()
            
            DatePicker(
                "Data de Entrega",
                selection: $dataDeEntrega,
                displayedComponents: [.date]
            )
            Divider()
            VStack{
                HStack {
                    Text("Valor do pedido")
                    Spacer()
                }
                TextField("R$", text: $valorPedido)
                    .onChange(of: valorPedido) {
                        if valorPedido == "R$"{
                            valorPedido = ""
                        } else if valorPedido != "" {
                            let novoValor = "R$" + "\(valorPedido.replacingOccurrences(of: "R$", with: ""))"
                            valorPedido = novoValor
                        }
                    }
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Status do Pagamento")
                
                Spacer()
                Picker("Selecione o status", selection: $statusPagamento) {
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
                TextEditor(text: $observacoes).frame(minHeight: 100).cornerRadius(8)
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
                        
                        viewModel.pedido = Pedido(
                            titulo: self.titulo,
                            observacoes: self.observacoes,
                            dataDeEntrega: self.dataDeEntrega,
                            cliente: self.cliente,
                            statusPagamento: self.statusPagamento
                        )
                        if idDoPedido != nil {
                            viewModel.editarPedido()
                        } else {
                            viewModel.salvarPedido()
                            print("Adicionando ao banco")
                            
                        }
                        
                        presentationMode.wrappedValue.dismiss()
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
