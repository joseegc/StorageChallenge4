//
//  CadastrarClienteView.swift
//  StorageChallenge
//
//  Created by JOSE ELIAS GOMES CAMARGO on 31/01/25.
//

import SwiftUI
import PhotosUI

struct CadastrarEditarClienteView: View {
    @EnvironmentObject var clientesViewModel: ClienteViewModel2
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @State private var imagem: UIImage?
    @State var photosPickerItem: PhotosPickerItem?
    
    @State var clienteInput = Cliente()
    var idDoCliente: UUID?
    
    @State var medidas :[Medida] = []
    
    
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
        formatter.maximumIntegerDigits = 4
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Spacer()
                    PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            fotoExibida
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 83, height: 83)
                                .clipShape(Circle())
                                .overlay {
                                    ZStack {
                                        Circle()
                                            .fill(Color(colorScheme == .dark ? Color("cinzaMedio"): Color("cinzaClaro")))
                                            .frame(width: 31, height: 31)
                                        Image(systemName: "camera").foregroundStyle(Color("pretoFixo"))
                                    }.offset(x: 25, y: 25)
                                }
                                .foregroundStyle(Color(colorScheme == .dark ? Color("cinzaClaro"): Color("cinzaEscuro")))
                    }.frame(width: 50, height: 50).padding(.top, 80)
                        .onChange(of: photosPickerItem) { _, _ in
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
                        }
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Nome", text: $clienteInput.nome)
                    Rectangle().fill(Color("cinzaEscuro")).frame(height: 1)
                }.padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5) {
                    TextField("Telefone", text: Binding(
                        get: { clienteInput.telefone ?? "" },
                        set: { clienteInput.telefone = $0 }
                    ))
                    .keyboardType(.decimalPad)
                    Rectangle().fill(Color("cinzaEscuro")).frame(height: 1)
                }.padding(.horizontal)
                
                
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Text("Medidas do Cliente").foregroundColor(colorScheme == .dark ? Color("amarelo") : Color("pretoFixo"))
                        Spacer()
                    }
                
                    
                    
                    // Exibe as medidas
                    ForEach($clienteInput.medidas, id: \.id) { $medida in
                        
                        
                        
                        
                        
                        VStack(spacing: 5) {
                            HStack {
                                // TextField para Descricao
                                TextField("Descrição", text: $medida.descricao) // Vincula diretamente ao estado da medida
                                
                                Spacer()
                                
                                HStack(spacing: 0) {
                                    // TextField para Valor (número)
                                    Rectangle()
                                        .fill(Color("cinzaEscuro"))
                                        .frame(width: 1)
                                        .padding(.trailing, 10)
                                    
                                    TextField("Valor", value: $medida.valor, formatter: numberFormatter)
                                        .frame(width: 45)
                                        .keyboardType(.decimalPad)
                                    
                                    
                                    
                                    Text("cm").padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                                    
                                }
                            }
                            Rectangle()
                                .fill(Color("cinzaEscuro"))
                                .frame(height: 1)
                        }
                        
                        .padding(.bottom, 10)
                    }
                    
                    Button(action: {
                        // Adiciona uma nova medida no estado local
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
            .navigationTitle(idDoCliente != nil ? "Editar Cliente" : "Cadastrar Cliente")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if idDoCliente != nil {
                    clientesViewModel.buscarClientePorId(id: idDoCliente!)
                    clienteInput = clientesViewModel.cliente
//                    clientesViewModel.buscarClientePorId(idDoCliente: idDoCliente!)
//                    if let foto = clientesViewModel.cliente.foto {
//                        imagem = UIImage(data: foto)
//                    }
//
                    
                    print(clienteInput.medidas)
                    
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
                        if let imageData = self.imagem?.pngData() {
                            clienteInput.foto = imageData
                        }
                        
//                        clienteInput.medidas = medidas
                        clientesViewModel.cliente.medidas = clienteInput.medidas
                      
//                        print("Salvando")
                        print("por aquii")
                        print(clienteInput.medidas)
//                        print(clientesViewModel.cliente.medidas)
                        clientesViewModel.cliente = clienteInput
                        print("PO AQUUUUIII")
                        print(clientesViewModel.cliente.medidas)
                        if idDoCliente != nil {
                            clientesViewModel.editarCliente()
                        } else {
//                            clientesViewModel.salvarCliente()
                            print("Adicionando ao banco")

                        }
                        
                        
//                        clientesViewModel.buscarClientesNoBanco()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(idDoCliente != nil ? "Editar" : "Salvar")
                    }
                }
            }
        }.padding(.top, 50)
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
    CadastrarEditarClienteView()
        .environmentObject(ClienteViewModel())
}
