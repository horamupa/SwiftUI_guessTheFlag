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
    @State var questNumber = 0
    
    @State var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var rightCountry = Int.random(in: 0...2)
    @State var wrongCountry = ""
    
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                VStack(spacing: 15) {
                    
                    VStack{
                        Text("Choose the flag of ")
                            .font(.subheadline.weight(.heavy))
                        Text("\(contries[rightCountry])")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
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
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("Score is: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Ask question", action: restart)
        } message: {
            Text("""
                Score is: \(score)
                """)
            
        }
    }
    
    func check(_ number: Int) {
        
        if number == rightCountry {
            scoreTitle = "Correct :)"
            score += 1
        } else {
            wrongCountry = contries[number]
            scoreTitle = """
                    Wrong :(
                    It's \(wrongCountry) flag
                    """
            
            
            if score > 0 {
                score -= 1
            }
        }
        showingScore = true
        questNumber += 1
        if questNumber == 8 {
            scoreTitle = "That's all! Great game!"
            questNumber = 0
        }
    }
    
    func restart() {
        contries.shuffle()
        rightCountry = Int.random(in: 0...2)
        if questNumber == 8 {
            
            scoreTitle = "That's all! Great game!"
            showingScore = true
            questNumber = 0
            score = 0
    }
    
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

