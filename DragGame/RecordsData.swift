//
//  RecordData.swift
//  DragGame
//
//  Created by Chase on 2021/4/6.
//

import Foundation
import SwiftUI

class RecordsData: ObservableObject{
    @AppStorage("records") var recordsData: Data?
    
    init(){
        if let recordsData = recordsData{
            let decoder = JSONDecoder()
            do{
                records = try decoder.decode([Record].self, from: recordsData)
            } catch{
                print(error)
            }
        }
    }
    
    
    @Published var records = [Record](){
        didSet{
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(records)
                recordsData = data
            } catch{
                print(error)
            }
        }
    }
    
    
}
