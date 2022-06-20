//
//  ContentView.swift
//  guessTheFlagUI.edition
//
//  Created by MM on 17.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingScore = false
    @State var score = 0
    @State var scoreTitle = ""
    
    @State var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var rightCountry = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                VStack{
                    Text("Choose the flag of ")
                        .font(.subheadline.weight(.heavy))
                    Text("\(contries[rightCountry])")
                        .font(.largeTitle.weight(.semibold))
                }.foregroundColor(.white)
                
                ForEach(0..<3) { number in
                    Button {
                        check(number)
                    } label: {
                        Image(contries[number])
                                                .renderingMode(.original)
                                                .clipShape(Capsule())
                                                .shadow(radius: 5)
                    }
                }
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Ask question", action: restart)
            } message: {
                Text("Your score is: \(score)")
        
            }
            }
    
    func check(_ number: Int) {
        if number == rightCountry {
            scoreTitle = "Correct :)"
            score += 1
        } else {
            scoreTitle = "Wrong :("
        }
        showingScore = true
    }
    
    func restart() {
        contries.shuffle()
        rightCountry = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
