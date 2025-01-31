//
//  StorageChallengeApp.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 30/01/25.
//

import SwiftUI

@main
struct StorageChallengeApp: App {
    @StateObject var coreDataModel = CoreDataModel()
    
    var body: some Scene {
        WindowGroup {
            ListarClientesView(clientesViewModel: ClienteViewModel())
        }
    }
}
