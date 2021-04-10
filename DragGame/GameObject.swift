//
//  GameObject.swift
//  DragGame
//
//  Created by Chase on 2021/3/29.
//
import SwiftUI
import Foundation

class GameObject: ObservableObject{
    @Published var isHomeView = true
    @Published var isGameView = false
    @Published var isGameOverView = false
    @Published var isEnterNameView = false
    @Published var isInfoView = false
    @Published var playerName = ""
    @Published var questionNum = 0
    @Published var correctNum = 0
    @Published var score = 0
    @Published var remainTime = 15
    @Published var isTimeUp = false
    @Published var secondsElapsed = 0
    @Published var frequency = 1.0
    @Published var timer: Timer?
    @Published var startDate: Date?
    
    
    @Published var selections = [SelectionObject(positionX: 66), SelectionObject(positionX: 166), SelectionObject(positionX: 266), SelectionObject(positionX: 366), SelectionObject(positionX: 466), SelectionObject(positionX: 566), SelectionObject(positionX: 666)]
    @Published var plates = [PlateObject(positionX: 50), PlateObject(positionX: 180), PlateObject(positionX: 310), PlateObject(positionX: 440), PlateObject(positionX: 570)]
    @Published var imageRandom: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    var questions = [
        Question(voc: "딸기케이크", answer: ["딸", "기", "케", "이", "크"], selection: ["딸", "기", "케", "이", "크", "퐁", "당"]),//  草莓蛋糕
        Question(voc: "바나나주스", answer: ["바", "나", "나", "주", "스"], selection: ["바", "나", "나", "주", "스", "레", "몬"]),//香蕉果汁
        Question(voc: "레몬에이드", answer: ["레", "몬", "에", "이", "드"], selection: ["레", "몬", "에", "이", "드", "로", "크"]),//檸檬汽水
        Question(voc: "퐁당쇼콜라", answer: ["퐁", "당", "쇼", "콜", "라"], selection: ["퐁", "당", "쇼", "콜", "라", "망", "고"]),//熔岩巧克力蛋糕
        Question(voc: "크로크무슈", answer: ["크", "로", "크", "무", "슈"], selection: ["크", "로", "크", "무", "슈", "이", "림"]),//烤起司總匯三明治
        Question(voc: "브라우니", answer: ["브", "라", "우", "니"], selection: ["브", "라", "우", "니", "티", "몬", "크"]),//布朗尼
        Question(voc: "치즈케이크", answer: ["치", "즈", "케", "이", "크"], selection: ["치", "즈", "케", "이", "크", "티", "라"]),//起司蛋糕
        Question(voc: "카푸치노", answer: ["카", "푸", "치", "노"], selection: ["카", "푸", "치", "노", "레", "몬", "이"]),//卡布奇諾
        Question(voc: "티라미수", answer: ["티", "라", "미", "수"], selection: ["티", "라", "미", "수", "딸", "기", "브"]),//提拉米蘇
        Question(voc: "망고스무디", answer: ["망", "고", "스", "무", "디"], selection: ["망", "고", "스", "무", "디", "케", "이"]),//芒果冰沙
        Question(voc: "아메리카노", answer: ["아", "메", "리", "카", "노"], selection: ["아", "메", "리", "카", "노", "바", "나"]),//美式咖啡
        Question(voc: "샌드위치", answer: ["샌", "드", "위", "치"], selection: ["샌", "드", "위", "치", "바", "나", "라"]),//三明治
        Question(voc: "아이스크림", answer: ["아", "이", "스", "크", "림"], selection: ["아", "이", "스", "크", "림","쇼", "콜"]),//冰淇淋
        Question(voc: "허니브레드", answer: ["허", "니", "브", "레", "드"], selection: ["허", "니", "브", "레", "드", "딸", "케"]),//蜂蜜麵包
    ]
    
    func clearObject(){
        playerName = ""
        questionNum = 0
        correctNum = 0
        score = 0
        remainTime = 15
        isTimeUp = false
        secondsElapsed = 0
        frequency = 1.0
    }
}
