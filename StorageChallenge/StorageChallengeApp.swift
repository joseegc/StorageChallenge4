//
//  StorageChallengeApp.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI
import SwiftData

@main
struct StorageChallengeApp: App {
    @StateObject var clienteViewModel = ClienteViewModel()
    //    @StateObject var pedidoViewModel = PedidoViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ClienteSwiftData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                SwiftDataTeste2View()
                    .modelContainer(for: ClienteSwiftData.self, inMemory: true)

            }
//            .modelContainer(sharedModelContainer)

            //                .environmentObject(pedidoViewModel)
        }
    }
}
