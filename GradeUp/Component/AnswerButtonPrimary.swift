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
        Button {
            onClick()
        } label : {
            Text(choice)
                .font(.system(size: 16))
                .foregroundStyle(.primaryText)
                .frame(width: 346, alignment: .leading)
                .padding(10)
                .background(.containerPrimary)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.25),radius: 4,x: 0, y: 4)
                .scaledToFit()
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    AnswerButtonPrimary(choice: "a) Splitting of a heavy nucleus into a smaller nuclei", onClick: {})
}
