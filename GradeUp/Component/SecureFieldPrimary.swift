//
//  SecureFieldPrimary.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 14/12/24.
//

import SwiftUI

struct SecureFieldPrimary: View {
    @Binding var textInput : String
    var placeholderText : String
    
    var body: some View {
        SecureField(placeholderText, text: $textInput)
            .font(.system(size: 15))
            .padding(10)
            .background(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

#Preview {
    SecureFieldPrimary(textInput: .constant(""), placeholderText: "Password")
}
