//
//  TabbarView.swift
//  StorageChallenge
//
//  Created by ALINE FERNANDA PONZANI on 31/01/25.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        TabView {
            NavigationStack{
                ListaDeClientesView()
            }.tabItem {
                    Label("Clientes", systemImage: "person.3.fill")
                }
        }.accentColor(colorScheme == .dark ? Color.white : Color.black)
        
        
    }
}

#Preview {
    TabBarView()
        .environmentObject(ClienteViewModel(bancoDeDados: SwiftDataImplementacao()))
}
