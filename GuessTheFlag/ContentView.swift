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

    
    var body: some View {
        ZStack {
            Color.blue
         
            VStack(spacing: 20) {
                Text("Tap the flag of")
                Text("UK")
                
                ForEach(0..<3, id: \.self) {
                    Image(countries[$0])
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
