//
//  ExibirPedidoView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 14/02/25.
//

import SwiftUI

struct ExibirPedidoView: View {
    @EnvironmentObject var viewModel: PedidoViewModel
    @State var pedido: Pedido
    var body: some View {
        VStack{
            
            Text(pedido.titulo)
            Text(pedido.titulo)
        }.navigationTitle(pedido.titulo)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.corDeFundo))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                pedido = viewModel.buscarPedido(pedido: pedido)!
            }
    }
}

#Preview {
    NavigationStack{
        ExibirPedidoView(pedido: Pedido(titulo: "Teste"))
    }
}
