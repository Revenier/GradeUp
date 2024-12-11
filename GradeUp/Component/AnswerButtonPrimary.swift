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
    @Binding var isSelected : Bool
    var body : some View {
        GeometryReader { geometry in
            Button {
                onClick()
            } label : {
                Text(choice)
                    .font(.system(size: geometry.size.width * 0.05))
                    .foregroundStyle(.primaryText)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                    .padding(10)
                    .background(isSelected ? .bluePastel : .containerPrimary)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.25),radius: 4,x: 0, y: 4)
                    .scaledToFit()
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
        }
       
    }
}

#Preview {
    AnswerButtonPrimary(choice: "a) Splitting of a heavy nucleus into a smaller nucleiawdwd", onClick: {}, isSelected: .constant(false))
}
