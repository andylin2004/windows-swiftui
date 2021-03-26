//
//  ContentView.swift
//  windows-swiftui
//
//  Created by Andy Lin on 3/25/21.
//

import SwiftUI

public var minPos: Double = 1;

struct ContentView: View {
    
    var body: some View{
        ZStack{
            RandomView()
            RandomView()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
