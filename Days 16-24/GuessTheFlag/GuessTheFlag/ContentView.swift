//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by User on 2021-09-03.
//

import SwiftUI

struct FlagView: View, Identifiable {
    var id: Int
    var image: Image
    
    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
    }
}

struct ContentView: View {
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var userTappedOnCorectAnswer = false
    @State private var presentAlert = false
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.00

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
                            withAnimation {
                                self.animationAmount = -360
                                self.opacityAmount = 0.75
                                tapTheFlag(flag)
                            }


                        },
                        label: {
                            
                            FlagView(id: flag, image: Image(flags[flag]))
                                .rotation3DEffect(flags[flag] == flags[correctAnswer] && userTappedOnCorectAnswer ? .degrees(animationAmount) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                                .opacity(flags[flag] == flags[correctAnswer] && userTappedOnCorectAnswer ? 1 : opacityAmount)

                                .animation(.default)


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

            userTappedOnCorectAnswer.toggle()
            scoreTitle = "Correct"
            score += 1

//            withAnimation{
                askQuestion()
//            }

        } else {
            scoreTitle = "Wrong! That's the flag of \(flags[number])"
            score -= 1
//            withAnimation{
                askQuestion()
//            }
        }
    }
    
    func askQuestion() {
        flags.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        userTappedOnCorectAnswer = false
        animationAmount = 0
        opacityAmount = 1

        presentAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
