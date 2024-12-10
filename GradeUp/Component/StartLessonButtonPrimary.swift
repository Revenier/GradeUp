//
//  StartButtonPrimary.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI

struct StartLessonButtonPrimary : View {
    
    var onClick : (() -> Void)
    
    var body : some View {
        Button {
            onClick()
        } label : {
            Text("Start Lesson")
                .font(.system(size: 8))
                .foregroundStyle(.primaryText)
                .frame(width: 69, height: 24)
                .background(Color.background)
                .cornerRadius(13)
        }
    }
}

#Preview {
    StartLessonButtonPrimary(onClick: {})
}
