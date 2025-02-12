//
//  CadastrarEditarPedidoView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 04/02/25.
//

import SwiftUI

struct CadastrarEditarPedidoView: View {
    
    
    var cliente: Cliente?
    var idDoPedido: UUID?
    
    @State var clienteInput = ""
    @State var selectedDate: Date = Date()
    @State var observacao: String = ""
    
    var body: some View {
        ScrollView {
            TextField("Titulo", text: $clienteInput)
            DatePicker("Data de entrega", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            VStack{
                HStack{
                    Text("Obsevações")
                    Spacer()
                }
                TextEditor(text: $observacao) // Campo de texto multilinha
                                .frame(height: 150) // Define uma altura para o editor
                                .border(Color.gray, width: 1)
            }
        }
    }
}

#Preview {
    CadastrarEditarPedidoView()
}
