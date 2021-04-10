//
//  GameView.swift
//  DragGame
//
//  Created by Chase on 2021/3/29.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @StateObject var recordsData = RecordsData()
    @EnvironmentObject var gameObject: GameObject
    @State private var plateSize: CGFloat = 80
    @State private var cakeSize: CGFloat = 80
    @State private var correctWord = 0
    @State private var isNewQuestion = false
    
    var uhohPlayer: AVPlayer{AVPlayer.sharedUhohPlayer}
    var dingdingPlayer: AVPlayer{AVPlayer.sharedDingdingPlayer}
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                //Color(red: 237/255, green: 242/255, blue: 251/255).ignoresSafeArea()
                Image("back2")
                    .resizable()
                    .opacity(0.7)
                    .ignoresSafeArea()
                HStack{//題號 時間
                    Image("people")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text("\(gameObject.questionNum+1)")
                                .font(.system(size: 25, weight: .heavy))
                        )
                        .offset(x: -20)
                    //Text("第\(gameObject.questionNum+1)位")
                    //Text(gameObject.questions[gameObject.questionNum].voc)
                    TimerView(remainTime: gameObject.remainTime)
                    Image("score")
                        .resizable()
                        .frame(width:70, height: 70)
                        .scaleEffect()
                        .overlay(
                            Text("\(gameObject.score)")
                                .foregroundColor(Color(red: 255/255, green: 213/255, blue: 8/255))
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .offset(y: 8)
                        )
                        .offset(x: 50, y: -5)
                        .onTapGesture(count: 5) {
                            stop()
                            withAnimation{
                                gameObject.isEnterNameView = true
                            }
                            gameObject.questionNum = 9
                            changeQuestion()
                        }
                }
                .offset(y: -145)
                ZStack{
                    //對話框
                    Image("chat")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .position(x: geometry.size.width/2-80, y: geometry.size.height/2-15)
                    //人
                    Image("people\(gameObject.questionNum)")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2+20)
                    //圖案
                    Button(action: {
                        speak(str: gameObject.questions[gameObject.questionNum].voc)
                        
                    }){
                        if(gameObject.remainTime>0){
                            if(correctWord<gameObject.questions[gameObject.questionNum].answer.count){
                                Image(gameObject.questions[gameObject.questionNum].voc)
                                    .resizable()
                            }
                            else{
                                Image("in-love")
                                    .resizable()
                            }
                        }
                        else{
                            if(correctWord<gameObject.questions[gameObject.questionNum].answer.count){
                                Image("angry-2")
                                    .resizable()
                            }
                            else{
                                Image("in-love")
                                    .resizable()
                            }
                        }
                    }
                    .frame(width: 40, height: 40)
                    .position(x:geometry.size.width/2-80, y: geometry.size.height/2-15)
                    
                    
                    //盤子
                    ForEach(0..<gameObject.questions[gameObject.questionNum].answer.count, id: \.self){ index in
                        Image("plate")
                            .resizable()
                            .scaledToFit()
                            .frame(width: plateSize, height: plateSize, alignment: .center)
                            //.background(Color.red)
                            .position(x: gameObject.plates[index].positionX, y: gameObject.plates[index].positionY)
                    }
                    
                    //選項
                    ForEach(0..<gameObject.questions[gameObject.questionNum].selection.count, id: \.self){ index in
                        Image("cake\(gameObject.imageRandom[index])")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cakeSize, height: cakeSize, alignment: .center)
                            .overlay(
                                Text("\(gameObject.questions[gameObject.questionNum].selection[index])")
                                    .offset(y: CGFloat(20))
                                    .font(.system(size: 20, weight: .heavy))
                            )
                            //.background(Color.yellow)
                            .position(x: gameObject.selections[index].positionX, y:gameObject.selections[index].positionY)
                            .offset(gameObject.selections[index].oldOffset)
                            .gesture(
                                DragGesture(coordinateSpace: .global)
                                    .onChanged({ (value) in
                                        gameObject.selections[index].oldOffset.width = gameObject.selections[index].newOffset.width + value.translation.width
                                        gameObject.selections[index].oldOffset.height = gameObject.selections[index].newOffset.height + value.translation.height
                                    })
                                    .onEnded({ (value) in
                                        speak(str: gameObject.questions[gameObject.questionNum].selection[index])
                                        gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                                        let intersectionIndex = judgeIntersection(objectX: gameObject.selections[index].positionX + gameObject.selections[index].newOffset.width, objectY: gameObject.selections[index].positionY + gameObject.selections[index].newOffset.height, wordIndex: index)
                                        
                                        if(intersectionIndex==100 || isNewQuestion || intersectionIndex==200){//回到原位
                                            withAnimation{
                                                gameObject.selections[index].oldOffset = CGSize.zero
                                                gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                                            }
                                            if(intersectionIndex==200){
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    
                                                    uhohPlayer.playFromStart()
                                                }
                                            }
                                        }
                                        else{
                                            //放到盤子上
                                            withAnimation{
                                                gameObject.selections[index].oldOffset.width = gameObject.plates[intersectionIndex].positionX - gameObject.selections[index].positionX
                                                gameObject.selections[index].oldOffset.height = gameObject.plates[intersectionIndex].positionY - gameObject.selections[index].positionY - CGFloat(30)
                                                gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                dingdingPlayer.playFromStart()
                                            }
                                        }
                                        
                                    })
                            )
                    }
                    
                    if(gameObject.isEnterNameView){
                        EnterNameView()
                            .transition(.bottomTransition)
                    }
                    else{
                        EnterNameView()
                            .hidden()
                        
                    }
                }
                
            }
        }
        .onAppear{
            gameObject.questionNum=0
            gameObject.isEnterNameView = false
            changeCakeImg()
            adjustPlatePosition()
            for index in 0..<gameObject.questions[gameObject.questionNum].selection.count{
                withAnimation{
                    gameObject.selections[index].oldOffset = CGSize.zero
                    gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                }
            }
            for index in 0..<gameObject.questions.count{
                gameObject.questions[index].selection.shuffle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                speak(str: gameObject.questions[gameObject.questionNum].voc)
            }
            start()
        }
        
    }
    func start(){
        gameObject.remainTime = 15
        gameObject.secondsElapsed = 0
        gameObject.startDate = Date()
        gameObject.timer = Timer.scheduledTimer(withTimeInterval: gameObject.frequency, repeats: true){ timer in
            if let startDate = gameObject.startDate{
                gameObject.secondsElapsed = Int(timer.fireDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
                gameObject.isTimeUp = false
                
            }
            
            if gameObject.secondsElapsed > 16{
                gameObject.remainTime = 15
                gameObject.isTimeUp = true
                gameObject.secondsElapsed = 0
                gameObject.startDate = Date()
                changeQuestion()
            }
            else if(gameObject.secondsElapsed<=16&&gameObject.secondsElapsed>=1){
                gameObject.remainTime=16-gameObject.secondsElapsed
            }
            
            
        }
    }
    
    func stop(){
        gameObject.timer?.invalidate()
        gameObject.timer = nil
    }
    
    func changeCakeImg(){
        for index in 0..<gameObject.questions[gameObject.questionNum].selection.count{
            gameObject.imageRandom[index] = Int.random(in: 0...5)
        }
    }
    func judgeIntersection(objectX: CGFloat, objectY: CGFloat, wordIndex: Int)->Int{
        isNewQuestion = false
        let objectRect = CGRect(x: objectX, y: objectY, width: cakeSize, height: cakeSize)
        for index in (0..<gameObject.questions[gameObject.questionNum].answer.count){
            let targetRect = CGRect(x: gameObject.plates[index].positionX, y: gameObject.plates[index].positionY, width: plateSize, height: plateSize)
            let interRect = objectRect.intersection(targetRect)
            if(interRect.width>=60 && interRect.height>=60){
                if(gameObject.questions[gameObject.questionNum].answer[index].isEqual(gameObject.questions[gameObject.questionNum].selection[wordIndex])){
                    correctWord+=1
                    if(correctWord==gameObject.questions[gameObject.questionNum].answer.count){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            speak(str: gameObject.questions[gameObject.questionNum].voc)
                            gameObject.score = gameObject.score + gameObject.remainTime*10
                        }
                        stop()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            changeQuestion()
                            if(gameObject.questionNum<=9){
                                start()
                            }
                        }
                        
                        
                    }
                    return index
                }//放對位置
                else{
                    return 200//放錯
                }
                
            }
        }
        
        return 100//沒放到
        
    }
    func adjustPlatePosition(){
        let evenPositionX = [212, 312, 412, 512]
        let oddPositionX = [162, 262, 362, 462, 562]
        for index in 0..<gameObject.questions[gameObject.questionNum].answer.count{
            if(gameObject.questions[gameObject.questionNum].answer.count%2==0){
                gameObject.plates[index].positionX = CGFloat(evenPositionX[index])
            }
            else{
                gameObject.plates[index].positionX = CGFloat(oddPositionX[index])
            }
            
        }
        
        
        
    }
    func changeQuestion(){
        if(gameObject.questionNum+1>=10){
            print("inn")
            stop()
            gameObject.isEnterNameView = true
        }
        else{
            for index in 0..<gameObject.questions[gameObject.questionNum].selection.count{
                withAnimation{
                    gameObject.selections[index].oldOffset = CGSize.zero
                    gameObject.selections[index].newOffset = gameObject.selections[index].oldOffset
                }
            }
            correctWord = 0
            gameObject.questionNum+=1
            adjustPlatePosition()
            changeCakeImg()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                speak(str: gameObject.questions[gameObject.questionNum].voc)
            }
            isNewQuestion = true
        }
        
    }
    
    func speak(str: String){
        let utterance = AVSpeechUtterance(string: str)
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        let synthesizer = AVSpeechSynthesizer()
        
        synthesizer.speak(utterance)
    }
    
    
}

extension AVPlayer{
    static let sharedUhohPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "uhoh", withExtension: "mp3")
        else{
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }()
    
    static let sharedDingdingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "dingding", withExtension: "mp3")
        else{
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }()
    
    func playFromStart(){
        seek(to: .zero)
        play()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


struct EnterNameView: View {
    @StateObject var recordsData = RecordsData()
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
                Text("Game Over!!!\n")
                    .font(.system(size: 30))
                Text("請輸入名字")
                HStack{
                    TextField("", text: $gameObject.playerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    Button {
                        withAnimation{
                            gameObject.isEnterNameView = false
                        }
                        addToRecordsData()
                        gameObject.isGameView = false
                        gameObject.isGameOverView = true
                    } label: {
                        Text("完成")
                    }
                }
            }
        }
        
    }
    func addToRecordsData(){
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "y/MMM/d HH:mm"
        let newRecord = Record(name: gameObject.playerName, score: gameObject.score, time: formatter3.string(from: Date()))
        for index in 0..<recordsData.records.count{
            if(gameObject.playerName==recordsData.records[index].name){
                if(gameObject.score>=recordsData.records[index].score){
                    recordsData.records.remove(at: index)
                    recordsData.records.append(newRecord)
                    recordsData.records.sort {
                        $0.score > $1.score
                    }
                }
                return
            }
        }
        recordsData.records.append(newRecord)
        recordsData.records.sort {
            $0.score > $1.score
        }
        
    }
    
}

extension AnyTransition{
    static var topTransition: AnyTransition{
        let insertion = AnyTransition.offset(x: 0, y: UIScreen.main.bounds.size.height/2)
        let removal = AnyTransition.offset(x: 0, y: -1000)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var bottomTransition: AnyTransition{
        let insertion = AnyTransition.offset(x: 0, y: UIScreen.main.bounds.size.height/2)
        let removal = AnyTransition.offset(x: 0, y: 1000)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
}
