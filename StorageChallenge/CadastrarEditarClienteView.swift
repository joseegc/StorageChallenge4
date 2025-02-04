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
    @Environment(\.presentationMode) var presentationMode  // Acesso ao modo de apresentação

    @State var navegarParaListagemDeClientes = false
    @State private var imagem: UIImage?
    @State var photosPickerItem: PhotosPickerItem?
    
    var clienteInput: ClienteEntity?
    var idDoCliente: UUID?

    
    
    @State var medidas: [Medida] = []
    
    var fotoExibida: Image {
        if let imagem = self.imagem {
            return Image(uiImage: imagem)
        } else {
            return Image(systemName: "person.circle.fill")
                
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumSignificantDigits = 4
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Informações do cliente")                    .font(.title3)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 30) {
                
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    
                    HStack() {
                        Spacer()
                        fotoExibida
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 83, height: 83)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                            .foregroundStyle(Color("preto"))
                        Spacer()
                    }

                    
                }.onChange(of: photosPickerItem, { _, _ in
                    Task {
                        if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.imagem = image
                                }
                            }
                        }
                        photosPickerItem = nil
                    }
                })
                
                
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Nome", text: $clientesViewModel.cliente.nome)
                    Rectangle()
                        .fill(Color("cinzaEscuro"))
                        .frame(height: 1)
            
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Telefone", text: Binding(
                        get: { clientesViewModel.cliente.telefone ?? "" },  // Se nome for nil, usa ""
                        set: { clientesViewModel.cliente.telefone = $0 }
                    ))
                    .keyboardType(.decimalPad)
                    Rectangle()
                        .fill(Color("cinzaEscuro"))
                        .frame(height: 1)
                }
                
                
                
                
                VStack(alignment: .center) {
                    
                    HStack {
                        Spacer()
                        Text("Medidas do Cliente").foregroundStyle(Color("cinzaEscuro"))
                        Spacer()
                    }
                    
                    
                    ForEach(clientesViewModel.cliente.medidas ?? [], id: \.id) { medida in
                        VStack(spacing: 5) {
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
                                
                                HStack(spacing: 0) {
                                    // TextField para Valor (número)
                                    Rectangle()
                                        .fill(Color("cinzaEscuro"))
                                        .frame(width: 1)
                                        .padding(.trailing, 10)
                                   
                                    TextField("Valor", value: Binding(
                                        get: { medida.valor },
                                        set: { newValue in
                                            // Encontra o índice de 'medida' e atualiza seu valor
                                            if let index = clientesViewModel.cliente.medidas?.firstIndex(where: { $0.id == medida.id }) {
                                                clientesViewModel.cliente.medidas?[index].valor = newValue
                                            }
                                        }
                                    ), formatter: numberFormatter)
                                    .frame(width: 45)
                                    
                                    
                                    Text("cm").padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                                    
                                }
                            }
                            Rectangle()
                                .fill(Color("cinzaEscuro"))
                                .frame(height: 1)
                        }
                    }
                    
                    
                    
                     
                        
                        Button(action: {
                            clientesViewModel.cliente.medidas?.append(Medida())
                        }, label: {
                            HStack(spacing: 4) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color("preto"))
                                Text("Adicionar Medida")
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color("preto"))
                            }.padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                        }).background(Color(.white)).cornerRadius(20)

                        
                    
                }
                
                Button(action: {
                    
                    //guard let imagem = imagem else { return }
                    
                    if let imageData = self.imagem?.pngData() {
                        clientesViewModel.cliente.foto = imageData
                        //clientesViewModel.cliente.foto?.imagem = imageData
                    }
                    clientesViewModel.adicionarClienteAoBanco()
                    clientesViewModel.buscarClientesNoBanco()

                    presentationMode.wrappedValue.dismiss()
                 
                    
                }, label: {
                    Text(idDoCliente != nil ? "Editar" : "Cadastrar")
                        .frame(width: 200, height: 50)
                        .background(.blue)
                        .foregroundStyle(Color(.white))
                })
                
            }
            .padding(.horizontal)
            .padding(.vertical , 53)
            .background(Color("cinzaClaro"))
            .cornerRadius(20)
            
        }.padding(.horizontal, 21)
        .navigationTitle(idDoCliente != nil ? "Editar Cliente" : "Cadastrar Cliente")
        .task {
            if idDoCliente != nil {
                clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente!)
                if let foto = clientesViewModel.cliente.foto {
                    imagem = UIImage(data: foto)
                }
            } else {
                clientesViewModel.cliente = Cliente()
            }
//            clienteInput = clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente)
            
//            if let cliente = clienteInput {
//                clientesViewModel.cliente.id = cliente.id!
//                
//                
//                clientesViewModel.cliente.nome = cliente.nome ?? ""
//                
//                clientesViewModel.cliente.telefone = cliente.telefone ?? ""
//                
//                if let imagemSalva = cliente.foto {
//                    imagem = UIImage(data: imagemSalva)
//                }
//                
//                
//                if let medidasSalvas = cliente.medidas?.allObjects as? [MedidaEntity] {
//                    for medida in medidasSalvas {
//                        let medida = Medida(id: medida.id!, descricao: medida.descricao ?? "", valor: medida.valor)
//                        clientesViewModel.cliente.medidas?.append(medida)
//                    }
//                   
//                }
//                
//                
//             
//                
//            }
        }
    
        .onDisappear {
//            clientesViewModel.cliente = Cliente()
        }
        
    }
}

#Preview {
    CadastrarEditarClienteView().environmentObject(ClienteViewModel())
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
