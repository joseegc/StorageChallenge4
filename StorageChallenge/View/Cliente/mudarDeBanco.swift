//
//  mudarDeBanco.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 13/02/25.
//

import SwiftUI

struct mudarDeBanco: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel

    var body: some View {
        Button("Core Data") {
            clientesViewModel.bancoDeDados = CoreDataImplementacao()
        }
        
        Button("Swift Data") {
            clientesViewModel.bancoDeDados = SwiftDataImplementacao()

        }
    }
}

#Preview {
    mudarDeBanco()
}
