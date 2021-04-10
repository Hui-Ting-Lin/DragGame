//
//  Score.swift
//  DragGame
//
//  Created by Chase on 2021/4/6.
//

import Foundation

struct Record: Identifiable, Codable{
    var id = UUID()
    var name: String
    var score: Int
    var time: String
}
