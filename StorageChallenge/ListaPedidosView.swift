//
//  ListaPedidosView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct ListaPedidosView: View {
    @State var pedidos = ["teste","teste2"]
    
    var body: some View {
        List(pedidos){
            Text($0)
        }
    }
}

#Preview {
    ListaPedidosView()
}
