//
//  AnswerButtonPrimary.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI

struct AnswerButtonPrimary : View {
    var choice : String
    var onClick : (() -> Void)
    
    var body : some View {
        GeometryReader { geometry in
            Button {
                onClick()
            } label : {
                Text(choice)
                    .font(.system(size: geometry.size.width * 0.05))
                    .foregroundStyle(.primaryText)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                    .background(.containerPrimary)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.25),radius: 4,x: 0, y: 4)
                    .scaledToFit()
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
        }
       
    }
}

#Preview {
    AnswerButtonPrimary(choice: "a) Splitting of a heavy nucleus into a smaller nucleiawdwd", onClick: {})
}
