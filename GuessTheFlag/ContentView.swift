//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Khumbongmayum Tonny on 23/06/23.
//

import SwiftUI

struct ContentView: View {

    var countries: [String] = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ]
    
    var correctAnswers = Int.random(in: 0...2)
    
    @State private var scoreTitle: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.blue
         
            VStack(spacing: 20) {
                Text("Tap the flag of")
                Text(countries[correctAnswers])
                
                ForEach(0..<3, id: \.self) { index in
                    Image(countries[index])
                        .onTapGesture {
                            checkAnswer(id: index)
                            showAlert = true
                        }
                }
            }
        }
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showAlert) {
            
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
