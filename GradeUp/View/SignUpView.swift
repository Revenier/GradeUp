//
//  SignUpView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct SignUpView: View {
    @State var inputName : String = ""
    @State var inputGrade : String = ""
    @State var inputEmail : String = ""
    @State var inputPassword : String = ""
    
    
    var body: some View {
        TextFieldPrimary(textInput: $inputName, placeholderText: "Name")
            .padding(.top,37)
        TextFieldPrimary(textInput: $inputGrade, placeholderText: "Grade")
            .padding(.top,28)
        TextFieldPrimary(textInput: $inputEmail, placeholderText: "Email")
            .padding(.top,28)
        TextFieldPrimary(textInput: $inputPassword, placeholderText: "Password")
            .padding(.top,28)
        ButtonPrimary(title: "REGISTER", onClick: {})
            .padding(.top,32)
    }
}

#Preview {
    Main()
}
