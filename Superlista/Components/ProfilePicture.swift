//
//  ProfilePicture.swift
//  Superlista
//
//  Created by Luiz Eduardo Mello dos Reis on 19/10/21.
//

import SwiftUI

struct ProfilePicture: View {
    var username: String
    
    var viewWidth: CGFloat?
    var viewHeight: CGFloat?
    
    var circleWidth: CGFloat?
    var circleHeight: CGFloat?
    
    var body: some View {
        GeometryReader { geometryReader in
            ZStack {
                Color("Button")
                    .clipShape(Circle())
                
                Circle()
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 5))
                    .frame(width: circleWidth ?? 140, height: circleHeight ?? 140)
                
                let initialName = username.prefix(1)
                Text(String(initialName))
                    .foregroundColor(.white)
                    .font(.system(size: geometryReader.size.height > geometryReader.size.width ? geometryReader.size.width * 0.5: geometryReader.size.height * 0.5))
                
            }
        }
        .frame(width: viewWidth ?? 160, height: viewHeight ?? 160)
    }
}
