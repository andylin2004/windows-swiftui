//
//  WindowView.swift
//  windows-swiftui
//
//  Created by Andy Lin on 3/25/21.
//

import SwiftUI

struct WindowView<Content: View>: View {
    @State private var location: CGPoint = CGPoint(x: 500, y: 500)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    @State private var piority: Double = 1
    @Environment(\.colorScheme) var colorScheme
    let windowContents: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
            self.windowContents = content()
        }
    
    var body: some View {
        VStack(spacing: 0){
            Rectangle()
                .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
                .border(colorScheme == .dark ? Color.clear : Color.gray)
                .frame(width: 250, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .gesture(simpleDrag.simultaneously(with: fingerDrag))
            self.windowContents
                .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(colorScheme == .dark ? Color(UIColor.systemGray5) : Color.white)
        }.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 5)
        .position(location)
        .zIndex(piority)
    }
    
    var fingerDrag: some Gesture{
        DragGesture()
            .updating($fingerLocation){(value, fingerLocation, transaction) in fingerLocation = value.location}
    }
    
    var simpleDrag: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged {
                    value in
                    var newLocation = startLocation ?? location
                    newLocation.x += value.translation.width
                    newLocation.y += value.translation.height
                    self.location = newLocation
                    piority = minPos+1
                }.updating($startLocation){
                    (value, startLocation, transaction) in
                    startLocation = startLocation ?? location
                }
                .onEnded{_ in
                    minPos += 1
                    piority = minPos
                }
        }
}


struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
