//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by User on 2021-09-03.
//

import SwiftUI

struct ContentView: View {
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var presentAlert = false
    @State private var scoreTitle = ""
    @State private var flags = ["US", "Poland", "UK", "France", "Ireland", "Estonia", "Germany", "Italy", "Nigeria", "Monaco", "Russia", "Spain"].shuffled()
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .bottom, endPoint: .top).ignoresSafeArea()
            VStack(spacing: 20) {
                
                VStack {
                    Text("Tap the flag...")
                        .foregroundColor(.white)
                    Text(flags[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                }
                
                ForEach(0 ..< 3) { flag in
                    Button(
                        action: {
                            tapTheFlag(flag)
                        },
                        label: {
                            Image(flags[flag])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        })
                }
                Text("Your score: \(score)").font(.title2).foregroundColor(.white)
                Spacer()
            }
            .alert(isPresented: $presentAlert) {
                Alert(
                    title: Text(scoreTitle),
                        dismissButton: .default(Text("Continue")) {
                        askQuestion()
                    })
            }
            
        }
    }
    
    func tapTheFlag(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(flags[number])"
            score -= 1
        }
        presentAlert = true
    }
    
    func askQuestion() {
        flags.shuffle()
        presentAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
