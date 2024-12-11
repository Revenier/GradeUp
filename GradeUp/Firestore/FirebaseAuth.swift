//
//  FirebaseAuth.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 11/12/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

func registerUserInAuth(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else if let authResult = authResult {
            let user = User(name: "", grade: "", email: email, password: password)
            completion(.success(user))
        }
    }
}

func storeUserToFirebase(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
    let db = Firestore.firestore()
    
    // Get the current user's UID from Firebase Authentication
    guard let uid = Auth.auth().currentUser?.uid else {
        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
        return
    }
    
    // User data dictionary
    let userData: [String: Any] = [
        "name": user.name,
        "grade": user.grade ?? "",  // Provide default value if grade is nil
        "email": user.email,
        "password": user.password
    ]
    
    // Save user data to Firestore using the user's UID as document ID
    db.collection("users").document(uid).setData(userData) { error in
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}

func getUserFromFirebase(email: String, completion: @escaping (Result<User, Error>) -> Void) {
    let db = Firestore.firestore()
    
    db.collection("users")
        .whereField("email", isEqualTo: email)
        .getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                if let document = querySnapshot.documents.first {
                    let data = document.data()
                    if let name = data["name"] as? String,
                       let grade = data["grade"] as? String,
                       let email = data["email"] as? String,
                       let password = data["password"] as? String {
                        let user = User(name: name, grade: grade, email: email, password: password)
                        completion(.success(user))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing user data"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                }
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
            }
        }
}





