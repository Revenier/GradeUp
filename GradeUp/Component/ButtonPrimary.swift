//
//  ButtonPrimary.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct ButtonPrimary : View {
    var title : String
    var onClick : (() -> Void)
    
    var body : some View {
        Button {
            onClick()
        } label : {
            Text(title)
                .font(.system(size: 20,weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 150, height: 44)
                .background(Color.init(hex: "50575C"))
                .cornerRadius(10)
        }
    }
}

#Preview {
    ButtonPrimary(title: "Test", onClick: {})
}
