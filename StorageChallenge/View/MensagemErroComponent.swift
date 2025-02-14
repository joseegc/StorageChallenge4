//
//  MensagemErroComponent.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 13/02/25.
//

import Foundation
import SwiftUI


struct MensagemErroComponent: View {
    var mensagem: String
    
    var body: some View {
        
        Text(mensagem).bold().foregroundStyle(Color(.red)).font(.caption)
        
    }
}
