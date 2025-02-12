//
//  StorageChallengeApp.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI


@main
struct StorageChallengeApp: App {
    @StateObject var clienteViewModel = ClienteViewModel2(bancoDeDados: SwiftDataImplementacao())
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ListaDeClientes()
          }
            .environmentObject(clienteViewModel)
        }
    }
}
