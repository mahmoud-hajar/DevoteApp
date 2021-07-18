//
//  BlankView.swift
//  DevoteApp
//
//  Created by mahmoud hajar on 10/07/2021.
//

import SwiftUI

struct BlankView: View {
    
    var backgroundColor:Color
    var backgroundOpactiy:Double
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(backgroundColor)
        .opacity(backgroundOpactiy)
        .blendMode(.overlay)
        .ignoresSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, backgroundOpactiy: 0.3)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
