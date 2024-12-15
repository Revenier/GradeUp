//
//  ScorePageView.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 14/12/24.
//

import SwiftUI

struct ScorePageView: View {
    
    var score : Int
    @Binding var navigationPath : NavigationPath
    
    private let goal : Int = 100
    @State private var color : Color = .white
    private let width : CGFloat = 15
    @State private var opacity : CGFloat = 0
    @State private var progress : Int = 0;
    
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
            VStack {
                Text("Your Score")
                    .font(.system(size: 20, weight: .bold))
                ZStack {
                    Circle().stroke(color.opacity(0.3), lineWidth: width)
                    
                    Circle().trim(from: 0, to: CGFloat(progress)/CGFloat(goal))
                        .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .shadow(radius: 5)
                        .opacity(opacity)
                    
                    Text("\(score)").font(.system(size: 60))
                }.padding(80)
                
                ButtonSecondary(iconPos: .left, title: "Go Back To Chapter", onClick: {navigationPath.removeLast(2)}, isEnabled: .constant(true), titleSize: 15, width: 200, height: 30)
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
                if (score < 50) {
                    color = .red
                }
                else if (score <= 75){
                    color = .yellow
                }
                else if (score < 100){
                    color = .green
                }
                else {
                    color = .blue
                }
                withAnimation{
                    opacity = 1
                    progress = score
                }
            }
        }
    }
}

#Preview {
    ScorePageView(score: 69, navigationPath: .constant(NavigationPath()))
}
