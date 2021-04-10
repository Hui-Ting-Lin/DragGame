//
//  ViewController.swift
//  DragGame
//
//  Created by Chase on 2021/3/29.
//

import SwiftUI
import AVFoundation
import UIKit

struct ViewController: View {
    
    @StateObject var gameObject = GameObject()
    var body: some View {
        if(gameObject.isHomeView){
            HomeView().environmentObject(gameObject)
        }
        else if(gameObject.isGameView){
            GameView().environmentObject(gameObject)
        }
        else if(gameObject.isGameOverView){
            GameOverView().environmentObject(gameObject)
        }
        
    }
   
    
}





struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewController()
    }
}
