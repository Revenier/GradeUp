//
//  SignInView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct SignInView: View {
    
    @State var inputEmail : String = ""
    @State var inputPassword : String = ""
    
    @Binding var navigationPath : NavigationPath
    var body: some View {
        TextFieldPrimary(textInput: $inputEmail, placeholderText: "Email", isEditable: .constant(true))
            .padding(.bottom,29)
            .padding(.top,37)
        
        TextFieldPrimary(textInput: $inputPassword, placeholderText: "Password", isEditable: .constant(true))
        
        ButtonPrimary(title: "LOGIN", onClick: {
            print(inputEmail)
            navigationPath.append("Home")
        })
            .padding(.top,37)
    }
}

#Preview {
    Main()
}
