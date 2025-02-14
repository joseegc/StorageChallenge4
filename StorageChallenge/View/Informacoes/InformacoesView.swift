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
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Informações")
        .background(Color(.corDeFundo))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    NavigationStack {
        InformacoesView()
    }
}

