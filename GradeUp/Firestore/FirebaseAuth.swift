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
            let user = User(name: "", grade: "", email: email, password: password, DOB: "")
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
        "grade": user.grade ?? "",  
        "email": user.email,
        "password": user.password,
        "DOB": "",
        "ProfilePic":""
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

// buat di sign up, cek udh ada akun blm
func findUserFromFirebase(email: String, completion: @escaping (Result<User, Error>) -> Void) {
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
                       let password = data["password"] as? String,
                       let dob = data["DOB"] as? String
                    {
                        let user = User(name: name, grade: grade, email: email, password: password, DOB: dob)
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

// buat login doang hehehe
func signInUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}

// dapetin data-data user
func searchUserByEmail(email: String, completion: @escaping (Result<User?, Error>) -> Void) {
    let db = Firestore.firestore()

    db.collection("users")
        .whereField("email", isEqualTo: email)
        .limit(to: 1)
        .getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let document = querySnapshot?.documents.first else {
                completion(.success(nil)) // No user found
                return
            }

            let data = document.data()
            guard let name = data["name"] as? String,
                  let grade = data["grade"] as? String,
                  let email = data["email"] as? String,
                  let password = data["password"] as? String,
                  let dob = data["DOB"] as? String
            else {
                      completion(.failure(NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Data parsing error"]
                      )))
                      return
                  }

            let user = User(name: name, grade: grade, email: email, password: password, DOB: dob)
            completion(.success(user))
        }
}

// Update data akun user
func updateUserProfile(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
    let db = Firestore.firestore()
    
    db.collection("users")
        .whereField("email", isEqualTo: user.email)
        .getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let document = querySnapshot?.documents.first else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                return
            }

            document.reference.updateData([
                "name": user.name,
                "grade": user.grade,
                "DOB": user.DOB
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
}
