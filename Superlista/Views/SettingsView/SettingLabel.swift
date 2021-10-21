//
//  SettingLabel.swift
//  Superlista
//
//  Created by Luiz Eduardo Mello dos Reis on 19/10/21.
//

import SwiftUI

struct SettingLabel: View {
    @State var showingSheet = false
    
    var body: some View {
        VStack(spacing: 10){
            Button(action: {
                showingSheet = true
            }) {
                HStack {
                    Text("Editar perfil")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 20.0, weight: .bold))
                }
                .padding(20)
                .foregroundColor(.white)
                .background(Color("ButtonBG"))
                .cornerRadius(13)
            }
            .sheet(isPresented: $showingSheet) {
                EditProifleView()
            }
            
            Button(action: {
                print("Button tapped!")
            }) {
                HStack {
                    Text("Premium")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "crown.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 20.0, weight: .bold))
                }
                .padding(20)
                .foregroundColor(.white)
                .background(Color("ButtonBG"))
                .cornerRadius(13)
            }
            Button(action: {
                print("Button tapped!")
            }) {
                HStack {
                    Text("Contato")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "phone.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 20.0, weight: .bold))
                }
                .padding(20)
                .foregroundColor(.white)
                .background(Color("ButtonBG"))
                .cornerRadius(13)
            }
            Button(action: {
                print("Button tapped!")
            }) {
                HStack {
                    Text("Convide um amigo")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "bolt.heart")
                        .foregroundColor(.primary)
                        .font(.system(size: 20.0, weight: .bold))
                }
                .padding(20)
                .foregroundColor(.white)
                .background(Color("ButtonBG"))
                .cornerRadius(13)
            }
        }
    }
}

struct SettingLabel_Previews: PreviewProvider {
    static var previews: some View {
        SettingLabel()
    }
}
