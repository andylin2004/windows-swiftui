//
//  HelloView.swift
//  windows-swiftui
//
//  Created by Andy Lin on 3/25/21.
//

import SwiftUI

struct RandomView: View {
    var body: some View {
        WindowView(content: {
            Text("Hello world")
        }, height: 100, width: 350)
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}
