//
//  SignIn.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct SignIn: View {
    var body: some View {
        TextFieldPrimary(placeholderText: "Email")
            .padding(.bottom,29)
            .padding(.top,37)
        
        TextFieldPrimary(placeholderText: "Password")
        
        ButtonPrimary(title: "LOGIN", onClick: {})
            .padding(.top,37)
    }
}

#Preview {
    Main()
}
