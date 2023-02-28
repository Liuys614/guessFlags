//
//  ContentView.swift
//  guessFlags
//
//  Created by Chih-Wei Lin on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAns = Int.random(in: 0...2)
    @State var showScore = false
    @State var resultMsg = ""
    @State var score = 0
    @State var games = 0
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 20){
                    VStack{
                        Text("Tap the falg of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAns])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.regular))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            checkAns(number: number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .cornerRadius(8)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)/\(games)")
                    .foregroundColor(.white)
                    .font(.title3)
                Spacer()
            }.padding(20)
            
        }
        .alert(resultMsg, isPresented: $showScore){
            Button("continue", action: newGame)
        }message: {
            //Text("Your score is \(score)/\(games)")
        }
    }
    
    
    func checkAns(number: Int){
        if number==correctAns{
            score += 1
            resultMsg = "Nice job!!"
        }
        else{
            resultMsg = "Wrong it's \(countries[number])"
        }
        showScore = true
    }
    
    func newGame(){
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
        games += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
