//
//  StartButtonPrimary.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI

struct StartButtonPrimary : View {
    
    var onClick : (() -> Void)
    
    var body : some View {
        Button {
            onClick()
        } label : {
            Text("Start Lesson")
                .font(.system(size: 8))
                .foregroundStyle(.primaryText)
                .frame(width: 56, height: 16)
                .background(Color.background)
                .cornerRadius(13)
        }
    }
}

#Preview {
    StartButtonPrimary(onClick: {})
}
