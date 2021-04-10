//
//  GameOverView.swift
//  DragGame
//
//  Created by Chase on 2021/4/8.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var gameObject: GameObject
    @State private var isRankView = false
    var body: some View {
        ZStack{
            Image("back2")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("遊戲結束\n")
                    .font(.system(size: 40))
                
                HStack{
                    Text("獲得了")
                    Text("\(gameObject.score)")
                        .font(.system(size: 30))
                    Text("分")
                }
                HStack{
                    Button(action: {
                        gameObject.clearObject()
                        gameObject.questions.shuffle()
                        gameObject.isHomeView = true
                        gameObject.isGameOverView = false
                        
                    }){
                        VStack{
                            Image("house")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("主畫面")
                        }
                        
                    }
                    .offset(x: -40)
                    
                    Button(action: {
                        withAnimation{
                            isRankView = true
                        }
                    }){
                        VStack{
                            Image("ranking")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("排行榜")
                        }
                    }
                    Button(action: {
                        gameObject.clearObject()
                        gameObject.questions.shuffle()
                        gameObject.isGameView=true
                        gameObject.isGameOverView=false
                    }){
                        VStack{
                            Image("play")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("再一次")
                        }
                        
                    }
                    .offset(x: 40)
                    
                }
            }
            if(isRankView){
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color(red: 250/255, green: 243/255, blue: 221/255))
                        .frame(width: 600, height: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(Color(red: 255/255, green: 166/255, blue: 158/255), lineWidth: 6)
                                .frame(width: 600, height: 300)
                        )
                    VStack{
                        RecordsView()
                            .frame(width: 380, height: 280)
                        Button(action: {
                            withAnimation{
                                isRankView = false
                            }
                            
                        }){
                            Text("返回")
                        }
                        
                    }
                    .frame(width: 380, height: 280)
                }
                .transition(.bottomTransition)
            }
            else{
                ZStack{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color(red: 250/255, green: 243/255, blue: 221/255))
                        .frame(width: 600, height: 320)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(Color(red: 255/255, green: 166/255, blue: 158/255), lineWidth: 6)
                                .frame(width: 600, height: 320)
                        )
                    VStack{
                        RecordsView()
                            
                        Button(action: {
                            withAnimation{
                                isRankView = false
                            }
                            
                        }){
                            Text("返回")
                        }
                        
                    }
                    
                }
                .hidden()
                
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
