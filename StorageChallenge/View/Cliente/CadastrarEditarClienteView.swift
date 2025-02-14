//
//  CadastrarClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI
import PhotosUI

struct CadastrarEditarClienteView: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State var imagem: UIImage?
    @State var photosPickerItem: PhotosPickerItem?
    
    @State var clienteInput = Cliente()
    var idDoCliente: UUID?
    
    @State var medidas :[Medida] = []
    @State var telefoneValido: Bool = true
    @State var nomeValido: Bool = true
    @State var medidasVazias: [Int] = []
    
    
    var fotoExibida: Image {
        if let imagem = self.imagem {
            return Image(uiImage: imagem)
        } else {
            return Image(systemName: "person.circle.fill")
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2 // Permite 2 casas decimais
        formatter.minimumFractionDigits = 0
        formatter.maximumIntegerDigits = 5
        return formatter
    }()
    
    func validarEntradaCliente() -> Bool {
        self.telefoneValido = NumeroTelefoneValido(clienteInput.telefone)
        self.nomeValido = !clienteInput.nome.isEmpty
        for (index, medida) in clienteInput.medidas.enumerated() {
            if medida.descricao.isEmpty {
                medidasVazias.append(index)
            }
        }

        guard telefoneValido, nomeValido, medidasVazias.isEmpty else { return false }
        
        return true
    }
    
    func NumeroTelefoneValido(_ numero: String) -> Bool {
        let regex = #"^\(\d{2}\)\s?\d{4,5}-\d{4}$"#
        let predicado = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicado.evaluate(with: numero)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Spacer()
                    PhotoPickerComponent(imagem: $imagem, photosPickerItem: $photosPickerItem)
                    Spacer()
                }
                
                CampoTextoComponent(
                    titulo: "Nome*",
                    texto: $clienteInput.nome,
                    valido: $nomeValido,
                    mensagemErro: nomeValido ? nil : "Nome é obrigatório!",
                    tipoCampo: .nome
                )
                
                CampoTextoComponent(
                    titulo: "Telefone*",
                    texto: $clienteInput.telefone,
                    valido: $telefoneValido,
                    teclado: .numberPad,
                    mensagemErro: telefoneValido ? nil : "Telefone inválido!",
                    tipoCampo: .telefone
                )
                
                
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Text("Medidas do Cliente").foregroundColor(colorScheme == .dark ? Color("amarelo") : Color("pretoFixo"))
                        Spacer()
                    }
                    
                    
                    // Exibe as medidas
                    ForEach(Array(clienteInput.medidas.enumerated()), id: \.element.id) { index, medida in
                        MedidaComponent(
                            medida: $clienteInput.medidas[index],
                            index: index,
                            medidasVazias: $medidasVazias,
                            clienteInput: $clienteInput.medidas,
                            removerMedida: {
                                if medidasVazias.contains(index) {
                                    medidasVazias.removeAll { $0 == index }
                                }
                                let idMedida = clienteInput.medidas[index].id
                                clienteInput.medidas.remove(at: index)
                                clientesViewModel.deletarMedida(id: idMedida)
                            },
                            clientesViewModel: clientesViewModel
                        )
                    }
                    
                    
                    Button(action: {
                        clienteInput.medidas.append(Medida())
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(colorScheme == .dark ? Color("amarelo"): Color("pretoFixo"))
                            Text("Adicionar Medida")
                                .font(.system(size: 13))
                                .foregroundColor(colorScheme == .dark ? Color("amarelo"): Color("pretoFixo"))
                        }
                        .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                    }
                    .background().foregroundColor(colorScheme == .dark ? Color("pretoFixo"): Color("cinzaMedio"))
                    .cornerRadius(20)
                }
                .padding(.horizontal)
                .padding(.vertical, 53)
                
                .cornerRadius(20)
            }
            .background(Color(colorScheme == .dark ? Color("pretoFixo"): Color("cinzaClaro")))
            .cornerRadius(20)
            .padding(.horizontal, 21)
            .padding(.bottom, 24)
            .navigationTitle(idDoCliente != nil ? "Editar Cliente" : "Cadastrar Cliente")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if idDoCliente != nil {
                    clienteInput = clientesViewModel.buscarClientePorId(id: idDoCliente!)!
                    //                    clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente!)
                    //                    if let foto = clientesViewModel.cliente.foto {
                    //                        imagem = UIImage(data: foto)
                    //                    }
                    //
                    
                    
                    if let imageData =  clienteInput.foto {
                        imagem =  UIImage(data: imageData)
                        
                    }
                }
                //                else {
                //                    clientesViewModel.cliente = Cliente()
                //                }
            }
            
            
            
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        
                        if !validarEntradaCliente() {
                            return
                        }
                        
                        
                        if let imageData = self.imagem?.pngData() {
                            clienteInput.foto = imageData
                        }
                        
                        //                        clienteInput.medidas = medidas
                        clientesViewModel.cliente.medidas = clienteInput.medidas
                        
                        
                        clientesViewModel.cliente = clienteInput
                        print(clientesViewModel.cliente.medidas)
                        if idDoCliente != nil {
                            clientesViewModel.editarCliente()
                        } else {
                            clientesViewModel.salvarCliente()
                            print("Adicionando ao banco")
                            
                        }
                        
                        
                        
                        clientesViewModel.buscarTodosClientes()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Salvar")
                        
                    }
                }
            }
        }.padding(.top, 50)
            .background(Color(.corDeFundo))
            .edgesIgnoringSafeArea(.bottom)
    }
}

extension UIImage {
    func resized(to maxWidth: CGFloat) -> UIImage? {
        let aspectRatio = self.size.height / self.size.width
        let height = maxWidth * aspectRatio
        let size = CGSize(width: maxWidth, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}


#Preview {
    NavigationStack {
        CadastrarEditarClienteView()
            .environmentObject(ClienteViewModel(bancoDeDados: SwiftDataImplementacao()))
    }
}
