//
//  StorageChallengeApp.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI

@main
struct StorageChallengeApp: App {
    @StateObject var clienteViewModel = ClienteViewModel(bancoDeDados: SwiftDataImplementacao())
    @StateObject var pedidoViewModel = PedidoViewModel(bancoDeDados: SwiftDataImplementacao())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ListaDeClientesView()
            }
            .environmentObject(clienteViewModel)
            .environmentObject(pedidoViewModel)
        }
    }
}
