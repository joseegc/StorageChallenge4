//
//  StorageChallengeApp.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI

@main
struct StorageChallengeApp: App {
    @StateObject var clienteViewModel = ClienteViewModel()
//    @StateObject var pedidoViewModel = PedidoViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ListaDeClientesView()
          }
            .environmentObject(clienteViewModel)

//                .environmentObject(pedidoViewModel)

        }
    }
}
