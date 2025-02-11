//
//  FotoSwiftData.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 11/02/25.
//

import Foundation
import SwiftData

@Model
final class FotoSwiftData {
    var imagem: Data
    
    init(imagem: Data) {
        self.imagem = imagem
    }
    
}

