//
//  EnterNameView.swift
//  DragGame
//
//  Created by Chase on 2021/4/8.
//

import SwiftUI

struct EnterNameView: View {
    @EnvironmentObject var gameObject: GameObject
    var body: some View {
        Button {
            gameObject.playerName = "9898"
            withAnimation{
                gameObject.isEnterNameView = false
            }
            gameObject.isGameView = false
            gameObject.isGameOverView = true
        } label: {
            
            Text("enter!")
        }
    }
}

struct EnterNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNameView()
    }
}
