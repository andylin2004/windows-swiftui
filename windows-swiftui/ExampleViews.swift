//
//  ExampleViews.swift
//  windows-swiftui
//
//  Created by Andy Lin on 3/25/21.
//

import SwiftUI
import Foundation

struct TextView: View {
    var body: some View {
        WindowView(content: {
            Text("Hello world")
        }, height: 100, width: 350, title: "Hello world")
    }
}

struct ListView: View{
    var body: some View{
        WindowView(content: {
            List{
                Text("Pikachu")
                Text("Raichu")
                Text("Gorochu")
            }
        }, title: "List")
    }
}

struct TimeView: View {
    var body: some View{
        WindowView(content: {
            Text(Date(), style: .time)
        }, title: "Time")
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
        ListView()
        TimeView()
    }
}
