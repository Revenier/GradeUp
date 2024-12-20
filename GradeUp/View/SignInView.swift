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
    @State private var errorMessage: String = ""
    @State private var isToastVisible: Bool = false
    
    @Binding var navigationPath : NavigationPath
    
    
    
    var body: some View {
        TextFieldPrimary(textInput: $inputEmail, placeholderText: "Email", isEditable: .constant(true))
            .padding(.bottom,29)
            .padding(.top,37)
        
        SecureFieldPrimary(textInput: $inputPassword, placeholderText: "Password")
        
        ButtonPrimary(title: "LOGIN", onClick: {
            print(inputEmail)
            loginHandler()
            
        })
            .padding(.top,37)
        ToastView(message: errorMessage, isShowing: $isToastVisible)
    }
    
    func loginHandler(){
        errorMessage = ""
        isToastVisible = false
        
//        Validation
        
        if inputEmail.isEmpty {
            errorMessage = "Email is required."
            isToastVisible = true
            showToastForDuration()
            return
        }
        
        if !isValidEmail(inputEmail) {
            errorMessage = "Email must end with @gmail.com."
            isToastVisible = true
            showToastForDuration()
            return
        }
        
        if inputPassword.isEmpty {
            errorMessage = "Password is required."
            isToastVisible = true
            showToastForDuration()
            return
        }
        
        func fetchUserData(userEmail: String) {
            searchUserByEmail(email: userEmail) { result in
                switch result {
                case .success(let user):
                    if let user = user {
                        UserDefaults.standard.set(user.grade, forKey: "Grade")
                        print("userGrade : \(user.grade)")
                        print("User data updated: \(user.name)")
                    } else {
                        print("No user found with the email \(userEmail)")
                    }
                case .failure(let error):
                    print("From Login : Error occurred: \(error.localizedDescription)")
                }
            }
        }
        
        signInUser(email: inputEmail, password: inputPassword) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            
                            fetchUserData(userEmail: inputEmail)
                            UserDefaults.standard.set(inputEmail, forKey: "userEmail")
                            navigationPath.append("Home")
                            inputEmail=""
                            inputPassword=""
                        case .failure(let error):
                            errorMessage = "Email or Password is incorrect."
                            isToastVisible = true
                            showToastForDuration()
                        }
                    }
                }
        
//     Validasi emailnya
        func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@gmail\\.com"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
           
//     Durasi toastnya 2 detik
        func showToastForDuration() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isToastVisible = false
            }
        }
    }
}

#Preview {
    Main()
}

