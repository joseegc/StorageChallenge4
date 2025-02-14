//
//  SwiftUIView.swift
//  StorageChallenge
//
//  Created by MATHEUS DA SILVA MARINI on 14/02/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerComponent: View {
    @Binding var imagem: UIImage?
    @Binding var photosPickerItem: PhotosPickerItem?
    @Environment(\.colorScheme) var colorScheme
    
    var fotoExibida: Image {
        if let imagem = self.imagem {
            return Image(uiImage: imagem)
        } else {
            return Image(systemName: "person.circle.fill")
        }
    }
    
    
    
    var body: some View {
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
    }
}

//#Preview {
//    PhotoPickerComponent()
//}
