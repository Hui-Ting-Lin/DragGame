//
//  HomeView.swift
//  DragGame
//
//  Created by Chase on 2021/3/29.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameObject: GameObject
    var body: some View {
        ZStack{
            Image("back3")
                .resizable()
                .scaledToFill()
                .opacity(0.8)
            HStack{
                Button {
                    gameObject.score = 0
                    gameObject.questions.shuffle()
                    gameObject.isHomeView = false
                    gameObject.isGameView = true
                    
                } label: {
                    ZStack{
                        Capsule(style: .continuous)
                            .foregroundColor(Color.white)
                            .frame(width: 120, height: 40)
                        Text("開始遊戲")
                            .font(.system(size: 25))
                    }
                }
                
                Button {
                    withAnimation{
                        gameObject.isInfoView = true
                    }
                } label: {
                    ZStack{
                        Capsule(style: .continuous)
                            .foregroundColor(Color.white)
                            .frame(width: 120, height: 40)
                        Text("遊戲說明")
                            .font(.system(size: 25))
                    }
                }
            }
            
            if(gameObject.isInfoView){
                InfoView()
                    .transition(.bottomTransition)
            }
            else{
                InfoView()
                    .hidden()
                
            }
        }
        
        .ignoresSafeArea()
        .onAppear{
            gameObject.playerName=""
        }
    }
}



struct InfoView: View {
    @EnvironmentObject var gameObject: GameObject
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(red: 250/255, green: 243/255, blue: 221/255))
                .frame(width: 400, height: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(Color(red: 255/255, green: 166/255, blue: 158/255), lineWidth: 6)
                        .frame(width: 400, height: 300)
                )
            VStack{
                ScrollView{
                    Text("✩你就是咖啡廳新來的工讀生吧？！\n✩今天總共有10位客人\n✩客人會告訴你他想要吃的食物\n✩依照客人所唸單字將有著韓文字的杯子蛋糕拖曳至盤子上以擺出正確順序才能送出餐點\n✩點擊食物圖片可以再聽一次單字\n✩客人很沒有耐心，所以必須在15秒內將餐點送出，不然客人會走掉的\n✩成功送出餐點可以獲得分數\n✩送出餐點後所剩時間愈多分數就會愈高\n✩努力得到最高分吧！")
                }
                Button("返回"){
                    withAnimation{
                        gameObject.isInfoView = false
                    }
                }
            }
            .frame(width: 380, height: 280)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
