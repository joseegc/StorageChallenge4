//
//  StorageChallengeApp.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI

@main
struct StorageChallengeApp: App {
    @StateObject var clientesViewModel = ClienteViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabbarView()
                .environmentObject(clientesViewModel)  // Passa o CoreDataModel para o ambiente

        }
    }
}
