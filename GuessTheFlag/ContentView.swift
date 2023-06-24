//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Khumbongmayum Tonny on 23/06/23.
//

import SwiftUI


struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            .padding()
            .shadow(radius: 1)
    }
}

extension View {
    func glassCardStyle() -> some View {
        modifier(GlassCard())
    }
}


struct ContentView: View {

    @State private var countries: [String] = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    
    @State private var correctAnswers = Int.random(in: 0...2)
    
    @State private var scoreTitle: String = ""
    @State private var showScore: Bool = false
    @State private var showRestartAlert: Bool = false
    @State private var score: Int = 0
    
    @State private var tappedFlag: Int?
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            
            AngularGradient(
                gradient: Gradient(colors: [.red, .blue, .yellow, .green, .purple, .orange, .mint]),
                center: .center
            )
            
            VStack {
                Spacer()
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack {
                    Text("Tap the flag of")
                        .font(.headline.weight(.heavy))
                        .foregroundColor(.secondary)
                    Text(countries[correctAnswers])
                        .font(.largeTitle.weight(.semibold))
                    
                    ForEach(0..<3) { index in
                        FlagImage(image: countries[index])
                            .onTapGesture {
                                onFlagTapped(id: index)
                                tappedFlag = index
                                withAnimation(.spring(response: 2, dampingFraction: 1)) {
                                    animationAmount += 360
                                }
                            }
                            .rotation3DEffect(
                                .degrees(
                                    (tappedFlag == index ? animationAmount : 0)
                                ),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                }
                .glassCardStyle()

                Spacer()
                
                Text("Score: \(score)")
                    .font(.title2.weight(.medium))
                
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        Button(action: {
                            tabRestartButton()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primary)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .buttonStyle(.borderedProminent)
                        })
                            .frame(width: 100, height: 100)
                    }
                }
                .alert("Warning!", isPresented: $showRestartAlert) {
                    Button("Restart", role: .destructive) {
                        resetGame()
                    }
                } message: {
                    Text("Do you want to restart the game?")
                }   
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
    
    func tabRestartButton() {
        showRestartAlert = true
    }
    
    func onFlagTapped(id: Int) {
        if id == correctAnswers {
            updateScore()
            scoreTitle = "🥳 Right! That's \(countries[id]) flag"
        } else {
            scoreTitle = "🙁 Wrong! That's the flag of \(countries[id])"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showScore = true
        }
    }
    
    
    func updateScore() {
        score += 1
    }
    
    func nextFlags() {
        countries.shuffle()
        correctAnswers = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        nextFlags()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var image: String

    var body: some View {
        Image(image)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.vertical, 5)
            .shadow(color: .purple.opacity(0.8), radius: 40, x: 0, y: 10)
    }
}
