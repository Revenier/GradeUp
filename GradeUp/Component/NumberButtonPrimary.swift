//
//  NumberBackgroundPrimary.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI

struct NumberButtonPrimary : View {
    var title : String
    var onClick : (() -> Void)
    
    var body : some View {
        Button {
            onClick()
        } label : {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(.primaryText)
                .frame(width: 39, height: 39).scaledToFill()
                .background(.containerPrimary)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.25),radius: 4,x: 0, y: 4)
                .scaledToFit()
        }
    }
}

#Preview {
    NumberButtonPrimary(title: "1", onClick: {})
}
