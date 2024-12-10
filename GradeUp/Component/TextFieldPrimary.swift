//
//  TextFieldPrimary.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct TextFieldPrimary: View {
    @Binding var textInput : String
    var placeholderText : String
    @Binding var isEditable : Bool
    
    var body: some View {
        TextField(placeholderText, text: $textInput)
            .disabled(!isEditable)
            .font(.system(size: 15))
            .padding(10)
            .background(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
    }
}


#Preview {
    TextFieldPrimary(textInput: .constant(""), placeholderText: "Test", isEditable: .constant(false))
}
