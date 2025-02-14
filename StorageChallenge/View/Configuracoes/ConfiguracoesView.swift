//
//  ConfiguracoesView.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 13/02/25.
//

import SwiftUI

struct ConfiguracoesView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: PoliticaDePrivacidadeView()) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Politica de Privacidade")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Divider()
                }
                .padding(.horizontal, 24)
                
            }
            
            NavigationLink(destination: TermosDeUsoView()) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Termos de Uso")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Divider()
                }
                .padding(.horizontal, 24)
                
                
            }
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ocupa todo o espaço


//        .background(Color.blue)
    
//        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ocupa todo o espaço

//        .background(Color.blue)
//        .padding(.horizontal, 24)
    .navigationTitle("Configurações")

    //            .navigationBarTitleDisplayMode(.inline)
        .background(Color(.corDeFundo))
        .edgesIgnoringSafeArea(.bottom)
    


    }
            
}

#Preview {
    NavigationStack {
        ConfiguracoesView()
    }
}



//
//import SwiftUI
//
//struct SegmentedPickerView: View {
//    // Estado para armazenar a opção selecionada (como String)
//    @State private var selectedOption: String
//    
//    // Lista de opções
//    let storageOptions = ["Core Data", "SwiftData"]
//    
//    // Inicializador para carregar a opção salva no UserDefaults
//    init() {
//        // Carregar o valor armazenado no UserDefaults, se houver, ou usar "Core Data" como padrão
//        let savedOption = UserDefaults.standard.string(forKey: "selectedStorageOption") ?? "Core Data"
//        _selectedOption = State(initialValue: savedOption)
//    }
//    
//    var body: some View {
//        VStack {
//            // Título
//            Text("Escolha o Tipo de Armazenamento")
//                .font(.title)
//                .padding()
//            
//            // Segmented Picker
//            Picker("Escolha uma opção", selection: $selectedOption) {
//                ForEach(storageOptions, id: \.self) { option in
//                    Text(option)
//                        .tag(option)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle()) // Estilo segmentado
//            
//            // Exibir a opção selecionada
//            Text("Você selecionou: \(selectedOption)")
//                .font(.headline)
//                .padding()
//            
//            Spacer()
//        }
//        .padding()
//        .onChange(of: selectedOption) { newValue in
//            // Armazenar a opção selecionada no UserDefaults quando mudar
//            UserDefaults.standard.set(newValue, forKey: "selectedStorageOption")
//        }
//    }
//}
//
//struct SegmentedPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SegmentedPickerView()
//    }
//}
