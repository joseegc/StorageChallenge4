////
////  PedidosView.swift
////  StorageChallenge
////
////  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
////
//
//import SwiftUI
//
//struct PedidosView: View {
//    @ObservedObject var pedidosViewModel: PedidosViewModel
//    @State var textoPedido: String = ""
//    
//    var body: some View {
//        VStack {
//            Text("Pedidos")
//            TextField("Adicionar titulo do pedido", text: $textoPedido)
//            
//            Button(action: {
//                pedidosViewModel.adicionar
//            }, label: {
//                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//            }
//        }
//    }
//}
//
//#Preview {
//    PedidosView(pedidosViewModel: PedidosViewModel())
//}
