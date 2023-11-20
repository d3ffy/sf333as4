//
//  ContentView.swift
//  SlideNumberPuzzle
//

import SwiftUI

struct ContentView: View {
    let columns = Array(repeating: GridItem(), count: 4)
    let gridSize = 4
    @State var message: String = ""
    @State var tapCountMsg: String = "Moved: 0"
    @State var tapCount: Int = 0
    @State var numbers = Array(0..<16)
    
    var body: some View {
        VStack {
            Text("Slide Number Puzzle")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.orange)
                .colorMultiply(.white)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(numbers, id: \.self) {
                    number in NumberGridCell(number: number, onTap: {
                        handleTap(number)

                    })
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: numbers)
                }
            }
            .padding()
            .onAppear{shuffle()}
            
            Text(tapCountMsg).font(.title)
            Text(message).font(.title).padding().foregroundStyle(Color.green)
            Button("Cheat") {
                cheatSolvePuzzle()
            }
            .foregroundStyle(Color.red)
            .frame(width: 70, height: 40)
            .border(Color.red, width: 3)
            .cornerRadius(10)
        }
    }
    
    func shuffle() {
        numbers.shuffle()
    }
    
    func isPuzzleSolved() -> Bool {
        if
            numbers.firstIndex(of: 1) == 0 &&
            numbers.firstIndex(of: 2) == 1 &&
            numbers.firstIndex(of: 3) == 2 &&
            numbers.firstIndex(of: 4) == 3 &&
            numbers.firstIndex(of: 5) == 4 &&
            numbers.firstIndex(of: 6) == 5 &&
            numbers.firstIndex(of: 7) == 6 &&
            numbers.firstIndex(of: 8) == 7 &&
            numbers.firstIndex(of: 9) == 8 &&
            numbers.firstIndex(of: 10) == 9 &&
            numbers.firstIndex(of: 11) == 10 &&
            numbers.firstIndex(of: 12) == 11 &&
            numbers.firstIndex(of: 13) == 12 &&
            numbers.firstIndex(of: 14) == 13 &&
            numbers.firstIndex(of: 15) == 14 &&
            numbers.firstIndex(of: 0) == 15
        {
            return true
        }
        return false
    }
    
    func cheatSolvePuzzle() {
        let solvedState = Array(1...15) + [0]
        numbers = solvedState
    }
    
    func handleTap(_ tappedNumber: Int) {
        guard let zeroIndex = numbers.firstIndex(of: 0),
              let tappedIndex = numbers.firstIndex(of: tappedNumber) else {
            return
        }

        if isValidMove(zeroIndex, tappedIndex) {
            numbers.swapAt(zeroIndex, tappedIndex)

            tapCount += 1
            tapCountMsg = "Moved: \(tapCount)"

            if isPuzzleSolved() {
                message = "You Won!!"
            }
        }
    }

    func isValidMove(_ index1: Int, _ index2: Int) -> Bool {
        let gridSize = 4
        let row1 = index1 / gridSize
        let col1 = index1 % gridSize
        let row2 = index2 / gridSize
        let col2 = index2 % gridSize

        return (row1 == row2 && abs(col1 - col2) == 1) || (col1 == col2 && abs(row1 - row2) == 1)
    }

}

struct NumberGridCell: View {
    let BUTTON_WIDTH: CGFloat = 80
    let BUTTON_HEIGHT: CGFloat = 80
    let number: Int
    let onTap: () -> Void

    var body: some View {
        Text(number == 0 ? "" : "\(number)")
            .frame(width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
            .background(number == 0 ? Color.clear : Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
            .font(.largeTitle)
            .onTapGesture(perform: onTap)
    }
}

#Preview {
    ContentView()
}
