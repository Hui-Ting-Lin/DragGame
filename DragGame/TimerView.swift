//
//  TimerView.swift
//  DragGame
//
//  Created by Chase on 2021/4/6.
//

import SwiftUI

struct TimerView: View {
    var remainTime: Int
    var totalTime: Int = 15
    var body: some View {
        ZStack{
            Capsule()
                .fill(Color.gray)
                .frame(width: 500, height: 20)
            Capsule()
                .fill(Color.yellow)
                .frame(width: 500*(CGFloat(remainTime)/CGFloat(totalTime)), height: 20)
                .offset(x: -500*(1-CGFloat(remainTime)/CGFloat(totalTime))/2)
            
            Image("clock")
                .resizable()
                .frame(width: 30, height: 30)
                .overlay(Text("\(remainTime)"))
                .offset(x: 500*(CGFloat(remainTime)/CGFloat(totalTime)-0.5))
                
            
        }
    }
}


