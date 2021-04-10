//
//  SelectionObject.swift
//  DragGame
//
//  Created by Chase on 2021/3/29.
//

import Foundation
import SwiftUI

struct SelectionObject{
    var positionX: CGFloat
    var positionY: CGFloat = 85
    var oldOffset = CGSize.zero
    var newOffset = CGSize.zero
}

struct PlateObject{
    var positionX: CGFloat
    var positionY: CGFloat = 300
}

struct Question{
    var voc: String
    var answer: [String]
    var selection: [String]
}
