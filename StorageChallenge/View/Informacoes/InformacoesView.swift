//
//  ConfiguracoesView.swift
//  StorageChallenge
//
//  Created by EDSON DE OLIVEIRA CORREIA on 13/02/25.
//

import SwiftUI

struct InformacoesView: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel

    @State var exibirModoDeDesenvolvedor = false
    @State var bancoDeDados = 1
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
                
            }
            .padding(.top, 24)
            
            NavigationLink(destination: TermosDeUsoView(exibirModoDeDesenvolvedor: $exibirModoDeDesenvolvedor)) {
                VStack(spacing: 16) {
                    HStack {
                        Text("Termos de Uso")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Divider()
                }
                
                
            }
            
            VStack(spacing: 8){
                if  (exibirModoDeDesenvolvedor) {

                HStack {
                    Text("Banco de Dados")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                
                    
                    Picker("Select Option", selection: $bancoDeDados) {
                        Text("Core Data")
                            .tag(0)
                        Text("Swift Data")
                            .tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: bancoDeDados) { bancoDeDados in
                        
                        if bancoDeDados == 0 {
                            clientesViewModel.bancoDeDados = CoreDataImplementacao()
                            
                        } else if bancoDeDados == 1 {
                            clientesViewModel.bancoDeDados = SwiftDataImplementacao()
                            
                        }
                    }
                }
            }
            .padding(.top, 24)
            Spacer()

        }
        .onAppear{
            exibirModoDeDesenvolvedor = UserDefaults.standard.bool(forKey: "modoDeDesenvolvedor")
        }
        .padding(.horizontal, 24)

        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ocupa todo o espaço


//        .background(Color.blue)
    
//        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ocupa todo o espaço

//        .background(Color.blue)
//        .padding(.horizontal, 24)
    .navigationTitle("Informações")

    //            .navigationBarTitleDisplayMode(.inline)
        .background(Color(.corDeFundo))
        .edgesIgnoringSafeArea(.bottom)
    


    }
            
}

#Preview {
    NavigationStack {
        InformacoesView()
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
