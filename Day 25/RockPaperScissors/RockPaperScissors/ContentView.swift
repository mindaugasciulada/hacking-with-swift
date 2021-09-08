//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by User on 2021-09-07.
//

import SwiftUI

enum Moves: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case rock
    case paper
    case scissors
}

struct ContentView: View {
    @State private var appMove = Moves.allCases.randomElement()
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("Enemy chose:").font(.largeTitle)
            
            Image(appMove!.rawValue)
                .resizable()
                .frame(width: 200, height: 200)
            
            Text("You need to \(shouldWin == true ? "win!" : "lose!")")
                .font(.largeTitle)
                .padding(.bottom, 200)
            
            HStack{
                ForEach(Moves.allCases) { move in
                    Button(
                        action: {
                            choose(move)
                        },
                        label: {
                            Image(move.rawValue)
                                .resizable()
                                .frame(width: 100, height: 100)
                        })
                }
            }
            .padding()
            Text("Score: \(score)")
                .font(.title2)
        }
    }
    
    private func playAgain() {
        shouldWin = Bool.random()
        appMove = Moves.allCases.randomElement()
    }
    
    private func choose(_ move: Moves) {
        
        var score = 0
        
        switch move {
        case .paper:
            if appMove == .rock {
                score += 1
            } else if appMove == .scissors {
                score -= 1
            }
        case .rock:
            if appMove == .paper {
                score -= 1
            } else if appMove == .scissors {
                score += 1
            }
        case .scissors:
            if appMove == .rock {
                score -= 1
            } else if appMove == .paper {
                score += 1
            }
        }
        
        if shouldWin {
            self.score += score
        } else {
            self.score -= score
        }
        
        playAgain()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
