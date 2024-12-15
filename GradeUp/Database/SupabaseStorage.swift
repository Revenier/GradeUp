//
//  SupabaseStorage.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 13/12/24.
//

//import UIKit
//import Supabase

//class StorageManager {
//    static let shared = StorageManager()
//    
//    private let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQwMTI3OTUsImV4cCI6MjA0OTU4ODc5NX0.HDr-eH9wQn1FqQeCW3dE1lXUG0xezCsGd0fxQlnAkkM"
//    
//    private let secret = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczNDAxMjc5NSwiZXhwIjoyMDQ5NTg4Nzk1fQ.0cnmbtqdVnQVvf6aTtNGXqSSGUS3ahE8pwydq9zRy9w"
//
//  //'init(configuration:)' declared here (Storage.SupabaseStorageClient)
//    lazy var storage = Storage.SupabaseStorageClient( configuration: <#StorageClientConfiguration#>, url : "https://lwwxyppgkrepgalqrxpw.supabase.co/storage/v1", headers: [
//        "Authorization" : "Bearer \(secret)",
//        "apikey" : apikey,
//    ])
//    
//    func uploadProfilePhoto(for email: String, photo: Data) async throws {
//        let file = File(name: "profile_photo", data: photo, fileName: "profile_photo.jpg", contentType: "jpg")
//        let result = try await storage.from("images").upload(path: "\(email)/profile_photo.jpg", file: file, options: FileOptions(cacheControl: "2400"))
//        return(result)
//    }
//}

//class StorageManager {
//    static let shared = StorageManager()
//
//    private let apikey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQwMTI3OTUsImV4cCI6MjA0OTU4ODc5NX0.HDr-eH9wQn1FqQeCW3dE1lXUG0xezCsGd0fxQlnAkkM"
//    private let secret = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczNDAxMjc5NSwiZXhwIjoyMDQ5NTg4Nzk1fQ.0cnmbtqdVnQVvf6aTtNGXqSSGUS3ahE8pwydq9zRy9w"
//
//    lazy var storage: SupabaseStorageClient = {
//        let config = SupabaseStorageClient.Configuration(
//            url: "https://lwwxyppgkrepgalqrxpw.supabase.co/storage/v1",
//            headers: [
//                "Authorization": "Bearer \(secret)",
//                "apikey": apikey
//            ]
//        )
//        return SupabaseStorageClient(configuration: config)
//    }()
//
//    func uploadProfilePhoto(for email: String, photo: Data) async throws -> String {
//        let file = File(
//            name: "profile_photo.jpg",
//            data: photo,
//            fileName: "profile_photo.jpg",
//            contentType: "image/jpeg"
//        )
//
//        // Uploading the file to the "images" bucket
//        let result = try await storage.from("images").upload(
//            path: "\(email)/profile_photo.jpg",
//            file: file,
//            options: FileOptions(cacheControl: "2400")
//        )
//
//        // Get the public URL of the uploaded file
//        guard let publicURL = storage.from("images").getPublicUrl(path: "\(email)/profile_photo.jpg") else {
//            throw NSError(domain: "StorageManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch public URL."])
//        }
//        return publicURL
//    }
//}

//
//func uploadImageToSupabase(
//    image: UIImage,
//    bucketName: String,
//    fileName: String,
//    completion: @escaping (String?) -> Void
//) {
//    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//        print("Failed to convert UIImage to Data")
//        completion(nil)
//        return
//    }
//
//    let supabaseURL = URL(string: "https://lwwxyppgkrepgalqrxpw.supabase.co")!
//    let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQwMTI3OTUsImV4cCI6MjA0OTU4ODc5NX0.HDr-eH9wQn1FqQeCW3dE1lXUG0xezCsGd0fxQlnAkkM"
//
//    // Initialize the storage client
//    let storage = StorageClient(url: supabaseURL.appendingPathComponent("/storage/v1"), headers: [
//        "Authorization": "Bearer \(supabaseKey)"
//    ])
//    let bucket = storage.from(bucketName: bucketName)
//
//    // Upload the file
//    bucket.upload(
//        path: fileName,
//        file: imageData,
//        fileOptions: StorageFileOptions(upsert: true)
//    ) { result in
//        switch result {
//        case .success(let file):
//            // Generate the public URL
//            let publicURL = bucket.getPublicUrl(path: fileName)
//            print("Image uploaded successfully. Public URL: \(publicURL)")
//            completion(publicURL)
//        case .failure(let error):
//            print("Error uploading image: \(error.localizedDescription)")
//            completion(nil)
//        }
//    }
//}
