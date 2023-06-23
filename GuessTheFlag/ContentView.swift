//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Khumbongmayum Tonny on 23/06/23.
//

import SwiftUI

struct ContentView: View {

    @State private var countries: [String] = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    
    @State private var correctAnswers = Int.random(in: 0...2)
    
    @State private var scoreTitle: String = ""
    @State private var showScore: Bool = false
    @State private var score: Int = 0
    
    var body: some View {
        ZStack {
            Color.blue
         
            VStack(spacing: 20) {
                Text("Tap the flag of")
                Text(countries[correctAnswers])
                
                ForEach(0..<3) { index in
                    Image(countries[index])
                        .onTapGesture {
                            checkAnswer(id: index)
                            showScore = true
                        }
                }
                Text("Score: \(score)")
            }
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Next", action: {
                nextFlags()
            })
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func checkAnswer(id: Int) {
        if id == correctAnswers {
            updateScore()
            scoreTitle = "Right! That's \(countries[id]) flag"
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[id])"
        }
    }
    
    func updateScore() {
        score += 1
    }
    
    func nextFlags() {
        countries.shuffle()
        correctAnswers = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
