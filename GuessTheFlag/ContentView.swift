//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sena Küçükerdoğan on 27.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var gameCount = 0
    @State private var score = 0
    
    var body: some View {
        ZStack {
            
            /*  RadialGradient(stops: [
             .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
             .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
             ],center: .top, startRadius: 200, endRadius: 700)
             */
            
            LinearGradient(colors: [.yellow.opacity(0.2), .yellow], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Spacer()
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.red)
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            //.foregroundStyle(.green)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            gameCount += 1
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                //.clipShape(.capsule)
                                .shadow(radius: 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding(30)
        }
        
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showingScore) {
            if gameCount != 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Reset", action: reset)
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        if gameCount == 8 {
            scoreTitle = "Game is Over!"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func reset() {
        score = 0
        gameCount = 0
    }
}

#Preview {
    ContentView()
}
