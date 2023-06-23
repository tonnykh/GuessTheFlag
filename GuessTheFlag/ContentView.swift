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
            }
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: {
                nextFlags()
            })
        } message: {
            Text("Your score is ???")
        }
    }
    
    func checkAnswer(id: Int) {
        if id == correctAnswers {
            scoreTitle = "Right"
        } else {
            scoreTitle = "Wrong"
        }
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
