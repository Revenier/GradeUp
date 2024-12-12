////
////  FirebaseStore.swift
////  GradeUp
////
////  Created by Kalyana Mitta on 11/12/24.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//func getSubjectsList(primary: String, completion: @escaping (Result<Grade?, Error>) -> Void) {
//    let db = Firestore.firestore()
//
//    db.collection("grades")
//        .whereField("grade", isEqualTo: primary)
//        .getDocuments { querySnapshot, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let document = querySnapshot?.documents.first else {
//                completion(.success(nil)) // No grade found
//                return
//            }
//
//            let data = document.data()
//            guard let subjects = data["subjects"] as? [[String: Any]] else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: ["Data parsing error": "Subjects missing"])))
//                return
//            }
//
//            let subjectList = subjects.compactMap { subjectData -> Subject? in
//                guard let name = subjectData["subject"] as? String,
//                      let chapters = subjectData["chapters"] as? [[String: Any]] else {
//                    return nil
//                }
//
//                let chapterList = chapters.compactMap { chapterData -> Chapter? in
//                    guard let name = chapterData["name"] as? String else {
//                        return nil
//                    }
//                    return Chapter(name: name, questions: <#[Question]#>)
//                }
//
//                return Subject(name: name, chapters: chapterList)
//            }
//
//            let grade = Grade(name: primary, subjects: subjectList)
//            completion(.success(grade))
//        }
//}
