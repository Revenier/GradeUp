//
//  SignUpView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State var inputName : String = ""
    @State var inputGrade : String?
    @State var inputEmail : String = ""
    @State var inputPassword : String = ""
    @State var errorMessage: String = ""
    @Binding var isUserRegisComplete : Bool
    
    @State private var isToastVisible: Bool = false
    
    var body: some View {
        TextFieldPrimary(textInput: $inputName, placeholderText: "Name", isEditable: .constant(true))
            .padding(.top,37)
        DropDownPrimary(hint: "Grade", options: ["Primary 1", "Primary 2", "Primary 3", "Primary 4", "Primary 5", "Primary 6"], isEditable: .constant(true), selection: $inputGrade)
            .padding(.top,28)
        TextFieldPrimary(textInput: $inputEmail, placeholderText: "Email", isEditable: .constant(true))
            .padding(.top,28)
        TextFieldPrimary(textInput: $inputPassword, placeholderText: "Password", isEditable: .constant(true))
            .padding(.top,28)
        ButtonPrimary(title: "REGISTER", onClick: {
//            manggil validasi buat cek inputnya. 
            registerUser()
        })
            .padding(.top,32)
        
        ToastView(message: errorMessage, isShowing: $isToastVisible)
    }
    
    func registerUser() {
        // Clear previous error message and hide toast
        errorMessage = ""
        isToastVisible = false
        
        // Validation checks
        if inputName.isEmpty {
            errorMessage = "Name is required."
            isToastVisible = true
            showToastForDuration()
            return
        }
        
        if inputGrade == nil {
            errorMessage = "Please select a grade."
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
        
        if inputPassword.count < 6 {
            errorMessage = "Password must be at least 6 characters long."
            isToastVisible = true
            showToastForDuration()
            return
        }

        // cek usernya udh ada belom
        findUserFromFirebase(email: inputEmail) { result in
            switch result {
            case .success:
                errorMessage = "This email is already registered."
                isToastVisible = true
                showToastForDuration()
                return
            case .failure:
                // kalau ga ada, store ke firebase trs pindah page
                Auth.auth().createUser(withEmail: inputEmail, password: inputPassword) { authResult, error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                        isToastVisible = true
                        showToastForDuration()
                        return
                    }
                    
                    let user = User(name: inputName, grade: inputGrade ?? "Unknown", email: inputEmail, password: inputPassword, DOB: "")
                    
                    storeUserToFirebase(user: user) { result in
                        switch result {
                            // kalau berhasil
                        case .success:
                            errorMessage = "Register Complete!"
                            isToastVisible = true
                            showToastForDuration()
                            isUserRegisComplete.toggle()
                            
                            // kalau gagal
                        case .failure(let error):
                            errorMessage = "Failed to save user data: \(error.localizedDescription)"
                            isToastVisible = true
                            showToastForDuration()
                        }
                    }
                }
            }
        }
    }

    
//    Validasi emailnya
        func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@gmail\\.com"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
    
//    Durasi toastnya 2 detik
        func showToastForDuration() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isToastVisible = false
            }
        }
}

#Preview {
    Main()
}
