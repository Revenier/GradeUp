//
//  SignUpView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct SignUpView: View {
    @State var inputName : String = ""
    @State var inputGrade : String?
    @State var inputEmail : String = ""
    @State var inputPassword : String = ""
    
    @Binding var isUserRegisComplete : Bool
    
    var body: some View {
        TextFieldPrimary(textInput: $inputName, placeholderText: "Name")
            .padding(.top,37)
        DropDownPrimary(hint: "Grade", options: ["Primary 1", "Primary 2", "Primary 3", "Primary 4", "Primary 5", "Primary 6"], selection: $inputGrade)
            .padding(.top,28)
        TextFieldPrimary(textInput: $inputEmail, placeholderText: "Email")
            .padding(.top,28)
        TextFieldPrimary(textInput: $inputPassword, placeholderText: "Password")
            .padding(.top,28)
        ButtonPrimary(title: "REGISTER", onClick: {
            
            isUserRegisComplete.toggle()
        })
            .padding(.top,32)
    }
}

#Preview {
    Main()
}
