//
//  WindowView.swift
//  windows-swiftui
//
//  Created by Andy Lin on 3/25/21.
//

import SwiftUI

struct WindowView<Content: View>: View {
    @State private var location: CGPoint = CGPoint(x: 200, y: 200)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    @State private var piority: Double = 1
    @State var remove = false
    @Environment(\.colorScheme) var colorScheme
    let windowContents: Content
    let height: CGFloat
    let width: CGFloat
    let title: String
    
    init(@ViewBuilder content: @escaping () -> Content, height: CGFloat = 250, width: CGFloat = 250, title: String = "") {
        self.windowContents = content()
        self.height = height
        self.width = width
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Rectangle()
                    .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
                    .frame(width: width, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    Button(action: {remove = true}, label: {
                        Circle()
                            .foregroundColor(Color.red)
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                    Spacer()
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.systemGray))
                    Spacer()
                }
                .frame(width: width-20)
            }.gesture(simpleDrag.simultaneously(with: fingerDrag))
            Group{
                Divider()
                    .frame(width: width)
                self.windowContents
                    .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(colorScheme == .dark ? Color(UIColor.systemGray5) : Color.white)
            }.gesture(dragDetect)
            .onTapGesture(count: 1){
                minPos += 1
                piority = minPos
            }
        }.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 5)
        .position(location)
        .zIndex(piority)
        .isHidden(remove, remove: remove)
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
    var dragDetect: some Gesture{
        DragGesture()
            .onChanged{_ in
                piority = minPos + 1
            }
    }
}

extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
