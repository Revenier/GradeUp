//
//  FirebaseStore.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 11/12/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


func fetchSubjectData(for gradeName: String, completion: @escaping ([Subject]) -> Void) {
    let db = Firestore.firestore()
    
    db.collection("grades").whereField("grade", isEqualTo: gradeName).getDocuments { snapshot, error in
        if let error = error {
            print("Error getting documents: \(error.localizedDescription)")
            return
        }
        
        guard let documents = snapshot?.documents else { return }
        
        for document in documents {
            let gradeData = document.data()
            
            if let gradeName = gradeData["grade"] as? String {
                
                var subjects: [Subject] = []
                
                if let subjectsArray = gradeData["subjects"] as? [[String: Any]] {
                    for subjectData in subjectsArray {
                        if let subject = subjectData["subject"] as? String {
                            
//                            if subject == subjectName {
                                var chapters: [Chapter] = []
                                
                                // Fetch chapters array
                                if let chaptersArray = subjectData["chapters"] as? [[String: Any]] {
                                    for chapterData in chaptersArray {
                                        if let chapter = chapterData["chapter"] as? String {
                                            
                                            // Check if this is the chapter the user selected
//                                            if chapter == chapterName {
                                            var questions: [Question] = []
                                                
                                                // Fetch questions array
                                                if let questionsArray = chapterData["questions"] as? [[String: Any]] {
                                                    for questionData in questionsArray {
                                                        
                                                        if let questionText = questionData["question"] as? String{
                                                            
                                                            if let answer = questionData["answer"] as? Int {
                                                                
                                                                // Fetch options array from Firestore
                                                                let options = questionData["options"] as? [String] ?? []
                                                                
                                                                // Create the Question object
                                                                let question = Question(number: questions.count + 1,
                                                                                        question: questionText,
                                                                                        options: options,
                                                                                        answer: answer)
                                                                questions.append(question)
                                                            }
                                                        }
                                                    }
                                                    
                                                    // Create the Chapter object with the filtered questions
                                                    let chapter = Chapter(name: chapter, questions: questions)
                                                    chapters.append(chapter)
                                                }
//                                            }
                                        }
                                    }
                                    
                                    // Create the Subject object with the filtered chapters
                                    let subject = Subject(name: subject, chapters: chapters)
                                    subjects.append(subject)
                                }
//                            }
                        }
                    }
                }
                

                let grade = Grade(name: gradeName, subjects: subjects)
                
                completion(subjects)
            }
        }
    }
}



func fetchQuestiontsData(for gradeName: String, subjectName: String, chapterName: String, completion: @escaping ([Question]) -> Void) {
    let db = Firestore.firestore()
    
    // Fetch the document where the "grade" field matches the provided gradeName
    db.collection("grades").whereField("grade", isEqualTo: gradeName).getDocuments { snapshot, error in
        if let error = error {
            print("Error getting documents: \(error.localizedDescription)")
            return
        }
        
        guard let documents = snapshot?.documents else { return }
        
        for document in documents {
            let gradeData = document.data()
            
            if let gradeName = gradeData["grade"] as? String {
                var subjects: [Subject] = []
                var questions: [Question] = [] // Initialize questions here
                
                // Fetch subjects array
                if let subjectsArray = gradeData["subjects"] as? [[String: Any]] {
                    for subjectData in subjectsArray {
                        if let subject = subjectData["subject"] as? String {
                            
                            // Check if this is the subject the user selected
                            if subject == subjectName {
                                var chapters: [Chapter] = []
                                
                                // Fetch chapters array
                                if let chaptersArray = subjectData["chapters"] as? [[String: Any]] {
                                    for chapterData in chaptersArray {
                                        if let chapter = chapterData["chapter"] as? String {
                                            
                                            // Check if this is the chapter the user selected
                                            if chapter == chapterName {
                                                
                                                // Fetch questions array
                                                if let questionsArray = chapterData["questions"] as? [[String: Any]] {
                                                    for questionData in questionsArray {
                                                        if let questionText = questionData["question"] as? String,
                                                           let answer = questionData["answer"] as? Int {
                                                            
                                                            // Fetch options array from Firestore
                                                            let options = questionData["options"] as? [String] ?? []
                                                            
                                                            // Create the Question object
                                                            let question = Question(number: questions.count + 1,
                                                                                     question: questionText,
                                                                                     options: options,
                                                                                     answer: answer)
                                                            questions.append(question)
                                                        }
                                                    }
                                                    
                                                    // Create the Chapter object with the filtered questions
                                                    let chapter = Chapter(name: chapter, questions: questions)
                                                    chapters.append(chapter)
                                                }
                                            }
                                        }
                                    }
                                    
                                    // Create the Subject object with the filtered chapters
                                    let subject = Subject(name: subject, chapters: chapters)
                                    subjects.append(subject)
                                }
                            }
                        }
                    }
                }
                

                let grade = Grade(name: gradeName, subjects: subjects)
                
                completion(questions)
            }
        }
    }
}

func fetchChaptersData(for gradeName: String, subjectName: String, completion: @escaping ([Chapter]) -> Void) {
    let db = Firestore.firestore()
    
    // Fetch the document where the "grade" field matches the provided gradeName
    db.collection("grades").whereField("grade", isEqualTo: gradeName).getDocuments { snapshot, error in
        if let error = error {
            print("Error getting documents: \(error.localizedDescription)")
            return
        }
        
        guard let documents = snapshot?.documents else { return }
        
        var Chapters: [Chapter] = [] // This will store the chapters you find
        
        for document in documents {
            let gradeData = document.data()
            
            if let gradeName = gradeData["grade"] as? String {
                // Fetch subjects array
                if let subjectsArray = gradeData["subjects"] as? [[String: Any]] {
                    for subjectData in subjectsArray {
                        if let subject = subjectData["subject"] as? String {
                            
                            // Check if this is the subject the user selected
                            if subject == subjectName {
                                
                                // Fetch chapters array
                                if let chaptersArray = subjectData["chapters"] as? [[String: Any]] {
                                    for chapterData in chaptersArray {
                                        if let chapter = chapterData["chapter"] as? String {
                                            
                                            // Check if this is the chapter the user selected
//                                            if chapter == chapterName {
                                                
                                                var questions: [Question] = [] // Initialize questions here
                                                
                                                // Fetch questions array
                                                if let questionsArray = chapterData["questions"] as? [[String: Any]] {
                                                    for questionData in questionsArray {
                                                        if let questionText = questionData["question"] as? String,
                                                           let answer = questionData["answer"] as? Int {
                                                            
                                                            // Fetch options array from Firestore
                                                            let options = questionData["options"] as? [String] ?? []
                                                            
                                                            // Create the Question object
                                                            let question = Question(number: questions.count + 1,
                                                                                     question: questionText,
                                                                                     options: options,
                                                                                     answer: answer)
                                                            questions.append(question)
                                                        }
                                                    }
                                                    
                                                    // Create the Chapter object with the filtered questions
                                                    let chapter = Chapter(name: chapter, questions: questions)
                                                    
                                                    // Add the chapter to foundChapters
                                                    Chapters.append(chapter)
                                                }
//                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // After processing all documents and chapters, return the found chapters
        completion(Chapters)
    }
}





func addSubscription(email: String, subscription: String, days: Int, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    // Fetch the user document based on email
    db.collection("users")
        .whereField("email", isEqualTo: email)
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                // Handle case where no document is found
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user found with this email"]))
                return
            }
            
            // Reference to the document
            let userRef = document.reference
            
            // Get the current date and calculate the expiration date based on daysToAdd
            let currentDate = Date()
            let calendar = Calendar.current
            let expirationDate = calendar.date(byAdding: .day, value: days, to: currentDate)!
            
            // Format the expiration date as a string (e.g., "yyyy-MM-dd HH:mm:ss")
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let expirationDateString = formatter.string(from: expirationDate)
            
            // Update the user document with subscription and expirationDate
            userRef.setData([
                "subscription": subscription,
                "expiredDate": expirationDateString
            ], merge: true) { error in
                // Pass any update error to the completion handler
                completion(error)
            }
        }
}

func getCurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let currentDate = Date()
    return dateFormatter.string(from: currentDate)
}

func uploadUrl(email: String, url: String, completion: @escaping (Error?) -> Void) {
    let db = Firestore.firestore()
    
    // Fetch the user document based on email
    db.collection("users")
        .whereField("email", isEqualTo: email)
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                // Handle case where no document is found
                completion(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user found with this email"]))
                return
            }
            
            let userRef = document.reference
            
            userRef.setData([
                "url": url
            ], merge: true) { error in
                completion(error)
            }
        }
}


