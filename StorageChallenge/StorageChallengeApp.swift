import SwiftUI

@main
struct StorageChallengeApp: App {
    @StateObject var clienteViewModel = ClienteViewModel(bancoDeDados: CoreDataImplementacao())
    
    var body: some Scene {
        WindowGroup {
                TabBarView()
            .environmentObject(clienteViewModel)
        }
    }
}
