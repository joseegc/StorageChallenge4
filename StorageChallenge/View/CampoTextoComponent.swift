//
//  CampoTextoComponent.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 14/02/25.
//

import SwiftUI

enum TipoCampo {
    case nome
    case telefone
    case padrao
}

struct CampoTextoComponent: View {
    var titulo: String
    @Binding var texto: String
    @Binding var valido: Bool
    var teclado: UIKeyboardType = .default
    var mensagemErro: String?
    var tipoCampo: TipoCampo = .padrao

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(titulo, text: $texto)
                .keyboardType(teclado)
                .onChange(of: texto) { novoValor in
                    texto = aplicarFormatacao(novoValor)
                    
                    if validarTexto(novoValor, tipoCampo: tipoCampo) {
                        valido = true
                    }
                }
            
            Rectangle()
                .fill(Color("cinzaEscuro"))
                .frame(height: 1)
            
            if !valido, let mensagemErro = mensagemErro {
                MensagemErroComponent(mensagem: mensagemErro)
            }
        }
        .padding(.horizontal)
    }

    func aplicarFormatacao(_ valor: String) -> String {
        switch tipoCampo {
        case .telefone:
            return formatarNumeroTelefone(valor)
        default:
            return valor
        }
    }

    // 📞 Formata o número de telefone automaticamente
    func formatarNumeroTelefone(_ numero: String) -> String {
        let digitos = numero.filter { "0123456789".contains($0) }

        if digitos.isEmpty { return "" }

        if digitos.count >= 11 {
            let area = digitos.prefix(2)
            let primeiraParte = digitos.dropFirst(2).prefix(5)
            let segundaParte = digitos.dropFirst(7).prefix(4)
            return "(\(area)) \(primeiraParte)-\(segundaParte)"
        } else if digitos.count > 6 {
            let area = digitos.prefix(2)
            let primeiraParte = digitos.dropFirst(2).prefix(4)
            let segundaParte = digitos.dropFirst(6).prefix(4)
            return "(\(area)) \(primeiraParte)-\(segundaParte)"
        } else if digitos.count > 2 {
            let area = digitos.prefix(2)
            let primeiraParte = digitos.dropFirst(2)
            return "(\(area)) \(primeiraParte)"
        } else if digitos.count == 2 {
            return "(\(digitos)"
        } else {
            return digitos
        }
    }
}


func validarTexto(_ valor: String, tipoCampo: TipoCampo) -> Bool {
    switch tipoCampo {
    case .telefone:
        return valor.count >= 13 // Número completo no formato (XX) XXXXX-XXXX
    case .nome:
        return !valor.isEmpty // Nome não pode ser vazio
    default:
        return true
    }
}
