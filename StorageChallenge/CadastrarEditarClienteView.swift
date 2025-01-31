//
//  CadastrarClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI
import PhotosUI

//class Medida {
//    @State var descricao: String
//   @State  var valor: Float
//    
//    init() {
//        descricao = ""
//        valor = 0
//    }
//}
struct CadastrarEditarClienteView: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel
    var tituloDaView = "Cadastrar Cliente"
    @Environment(\.presentationMode) var presentationMode  // Acesso ao modo de apresentação

    @State var navegarParaListagemDeClientes = false

    @State private var imagem: UIImage?
        @State var photosPickerItem: PhotosPickerItem?
    
    var cliente: ClienteEntity? = nil

    
    
    @State var medidas: [Medida] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                Text(clientesViewModel.cliente.nome)
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    
                    Image(uiImage: imagem ?? UIImage(named: "fotoPerfil")!.resized(to:200)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4))  // Optional: add a border
                    
                }
                
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Nome*")
                        .font(.title2)
                        .bold()
                    TextField("Nome*", text: $clientesViewModel.cliente.nome)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Medidas*")
                        .font(.title2)
                        .bold()
                    
                    
                    ForEach(clientesViewModel.cliente.medidas ?? [], id: \.id) { medida in
                        HStack {
                            // TextField para Descricao
                            TextField("Descriçao", text: Binding(
                                get: { medida.descricao },
                                set: { newValue in
                                    // Encontra o índice de 'medida' e atualiza sua descrição
                                    if let index = clientesViewModel.cliente.medidas?.firstIndex(where: { $0.id == medida.id }) {
                                        clientesViewModel.cliente.medidas?[index].descricao = newValue
                                    }
                                }
                            ))
                            Spacer()
                            
                            // TextField para Valor (número)
                            TextField("Valor", value: Binding(
                                get: { medida.valor },
                                set: { newValue in
                                    // Encontra o índice de 'medida' e atualiza seu valor
                                    if let index = clientesViewModel.cliente.medidas?.firstIndex(where: { $0.id == medida.id }) {
                                        clientesViewModel.cliente.medidas?[index].valor = newValue
                                    }
                                }
                            ), formatter: NumberFormatter())
                            .frame(width: 100)
                            
                            Text("cm")
                        }
                    }
                    
                    
                    
                    HStack {
                        
                        Button(action: {
                            clientesViewModel.cliente.medidas?.append(Medida())
                        }, label: {
                            Image(systemName: "plus")
                            Text("Adicionar Medida")
                        })
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Telefone*")
                        .font(.title2)
                        .bold()
                    TextField("Telefone", text: Binding(
                        get: { clientesViewModel.cliente.telefone ?? "" },  // Se nome for nil, usa ""
                        set: { clientesViewModel.cliente.telefone = $0 }
                    ))
                    .keyboardType(.numberPad)
                }
                
                Button(action: {
                    clientesViewModel.adicionarClienteAoBanco()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cadastrar")
                        .frame(width: 200, height: 50)
                        .background(.blue)
                        .foregroundStyle(Color(.white))
                })
                
            }
            .padding(.horizontal)
        }
        .navigationTitle(tituloDaView)
        .task {
            if let cliente = cliente {
                clientesViewModel.cliente.nome = cliente.nome ?? ""
                clientesViewModel.cliente.telefone = cliente.telefone
                
            }
        }
        
    }
}

#Preview {
    CadastrarEditarClienteView()
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
