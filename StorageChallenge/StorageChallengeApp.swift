import SwiftUI

@main
struct StorageChallengeApp: App {
    @StateObject var clienteViewModel = ClienteViewModel(bancoDeDados: SwiftDataImplementacao())
    
    var body: some Scene {
        WindowGroup {
                TabBarView()
            
            .environmentObject(clienteViewModel)
        }
    }
}
