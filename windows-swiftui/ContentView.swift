//
//  ContentView.swift
//  windows-swiftui
//
//  Created by Andy Lin on 3/25/21.
//

import SwiftUI

public var minPos: Double = 1;

struct ContentView: View {
    @State private var textViews = 1
    @State private var listViews = 1
    @State private var timeView = 0
    
    var body: some View{
        
        ZStack{
            ForEach(0..<textViews, id: \.self){ _ in
                TextView()
            }
            ForEach(0..<listViews, id: \.self){ _ in
                ListView()
            }
            ForEach(0..<timeView, id: \.self){ _ in
                TimeView()
            }
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                Menu("Add"){
                    Button("Text View"){
                        textViews += 1
                    }
                    Button("List View"){
                        listViews += 1
                    }
                    Button("Time View"){
                        timeView += 1
                    }
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
