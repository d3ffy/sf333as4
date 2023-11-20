//
//  ContentView.swift
//  SlideNumberPuzzle
//
//  Created by Tanasit Vanachayangkul on 20/11/2566 BE.
//

import SwiftUI


struct ContentView: View {
    let columns = Array(repeating: GridItem(), count: 4)
    @State var message: String = "Hello"
    @State var tapCountMsg: String = "Moved: 0"
    @State var tapCount: Int = 0
    @State var numbers = Array(0..<16)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(numbers, id: \.self) {
                    number in NumberGridCell(number: number)
                        .onTapGesture {
                            tapCount += 1
                            message = "Tapped: \(number)"
                            tapCountMsg = "Moved: \(tapCount)"
                        }
                }
            }
            .padding()
            .onAppear{shuffle()}
            
            Text(message)
            Text(tapCountMsg)
        }
    }
    
    func shuffle() {
        numbers.shuffle()
    }
}

struct NumberGridCell: View {
    let BUTTON_WIDTH: CGFloat = 80
    let BUTTON_HEIGHT: CGFloat = 80
    let number: Int

    var body: some View {
        Text(number == 0 ? "" : "\(number)")
            .frame(width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
            .background(number == 0 ? Color.clear : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
