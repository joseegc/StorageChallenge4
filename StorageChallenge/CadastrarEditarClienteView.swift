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
    
    @State var nome = ""
    @State var telefone = ""
    @State private var imagem: UIImage?
        @State var photosPickerItem: PhotosPickerItem?
    
    
    @State var medidas: [Medida] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    
                    Image(uiImage: imagem ?? UIImage(named: "fotoPerfil")!.resized(to:200)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4))  // Optional: add a border

                }
            
                        
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Nome")
                    .font(.title2)
                    .bold()
                TextField("Nome*", text: clientesViewModel.cliente.nome)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Medidas*")
                    .font(.title2)
                    .bold()
                
                
                //                ForEach(medidas, id: \.self) { medida in
                //                    TextField("Descricao", text: medida.descricao)
                //                }
                
                HStack {
                    
                    Button(action: {
//                        medidas.append(Medida())
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
                    TextField("Telefone", text: $telefone)
                        .keyboardType(.numberPad)
                }
            
            Button(action: {
                clientesViewModel.adicionarAoBanco()
            }, label: {
                Text("Cadastrar")
                    .frame(width: 200, height: 50)
                    .background(.blue)
                    .foregroundStyle(Color(.white))
            })
            
        }
        .padding(.horizontal)
        .navigationTitle(tituloDaView)
        
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
