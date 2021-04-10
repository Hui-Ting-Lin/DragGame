//
//  RecordsView.swift
//  DragGame
//
//  Created by Chase on 2021/4/6.
//

import SwiftUI

struct RecordsView: View {
    @StateObject var recordsData = RecordsData()
    
    var body: some View {
        ScrollView{
            HStack{
                Text("No.")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 100, height: 40, alignment: .center)
                Text("Name")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 100, height: 40, alignment: .center)
                Text("score")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 100, height: 40, alignment: .center)
                Text("TimeStamp")
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 200, height: 40, alignment: .center)
            }
            ForEach(recordsData.records.indices, id: \.self) { (index) in
                RecordRowView(record: recordsData.records[index], num: index)
            }
            
        }
    }
    
}
