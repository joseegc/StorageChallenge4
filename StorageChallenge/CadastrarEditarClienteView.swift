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
    
    var clienteInput: ClienteEntity?

    
    
    @State var medidas: [Medida] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                Text(clientesViewModel.cliente.nome)
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    
                    if let imagem = self.imagem {
                        Image(uiImage: imagem)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))  // Optional: add a border
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))  // Optional: add a border
                    }

                    
                }.onChange(of: photosPickerItem, { _, _ in
                    Task {
                        if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.imagem = image
                                    print("📸 Imagem carregada com sucesso") // Verifica se a imagem foi atribuída
                                }
                            } else {
                                print("⚠️ Erro ao converter data para UIImage")
                            }
                        } else {
                            print("⚠️ Erro ao carregar a imagem do PhotosPicker")
                        }
                        photosPickerItem = nil
                    }
                })
            

                
                
                
                
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
                    
                    //guard let imagem = imagem else { return }
                    
                    if let imageData = self.imagem?.pngData() {
                        clientesViewModel.cliente.foto = imageData
                        //clientesViewModel.cliente.foto?.imagem = imageData
                    }
                    clientesViewModel.adicionarClienteAoBanco()
                    
                    
                    clientesViewModel.cliente = Cliente()
                    
                        presentationMode.wrappedValue.dismiss()
                 
                    
                }, label: {
                    Text((clienteInput != nil) ? "Editar" : "Cadastrar")
                        .frame(width: 200, height: 50)
                        .background(.blue)
                        .foregroundStyle(Color(.white))
                })
                
            }
            .padding(.horizontal)
        }
        .navigationTitle(tituloDaView)
        .task {
            if let cliente = clienteInput {
                clientesViewModel.cliente.id = cliente.id!
                
                
                clientesViewModel.cliente.nome = cliente.nome ?? ""
                
                clientesViewModel.cliente.telefone = cliente.telefone ?? ""
                
                if let imagemSalva = cliente.foto {
                    imagem = UIImage(data: imagemSalva)
                }
                
                
                if let medidasSalvas = cliente.medidas?.allObjects as? [MedidaEntity] {
                    for medida in medidasSalvas {
                        let medida = Medida(descricao: medida.descricao ?? "", valor: medida.valor)
                        clientesViewModel.cliente.medidas?.append(medida)
                    }
                   
                }
                
                
             
                
            }
        }
    
        .onDisappear {
            clientesViewModel.cliente = Cliente()
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
