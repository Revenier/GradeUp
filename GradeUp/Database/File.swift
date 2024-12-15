//func uploadImageToSupabase(image: UIImage, bucketName: String, fileName: String, completion: @escaping (String?) -> Void) {
//    // Convert UIImage to Data
//    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//        print("Error converting UIImage to Data")
//        completion(nil)
//        return
//    }
//
//    // Get the Supabase storage client
//    let storage = SupabaseClient.s
//
//    // Reference to the bucket
//    let bucket = storage.from(bucketName)
//
//    // Upload the image data to the bucket
//    bucket.upload(path: fileName, file: imageData) { result in
//        switch result {
//        case .success(let file):
//            // Retrieve the public URL
//            guard let fileURL = bucket.getPublicUrl(path: file.key) else {
//                print("Failed to retrieve the public URL")
//                completion(nil)
//                return
//            }
//            print("Image uploaded successfully. URL: \(fileURL)")
//
//            // Pass the file URL to the completion handler
//            completion(fileURL)
//        case .failure(let error):
//            print("Error uploading image: \(error.localizedDescription)")
//            completion(nil)
//        }
//    }
//}




				
