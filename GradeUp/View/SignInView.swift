//
//  SignInView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var isLoginSuccess : Bool
    
    @State var inputEmail : String = ""
    @State var inputPassword : String = ""
    var body: some View {
        TextFieldPrimary(textInput: $inputEmail, placeholderText: "Email")
            .padding(.bottom,29)
            .padding(.top,37)
        
        TextFieldPrimary(textInput: $inputPassword, placeholderText: "Password")
        
        ButtonPrimary(title: "LOGIN", onClick: {
            print(inputEmail)
            isLoginSuccess.toggle()
        })
            .padding(.top,37)
    }
}

#Preview {
    Main()
}
