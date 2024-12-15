////
////  Supabase.swift
////  GradeUp
////
////  Created by Kalyana Mitta on 13/12/24.
////
//
import Supabase
import Foundation
import Storage
import SwiftUI

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://lwwxyppgkrepgalqrxpw.supabase.co")!,
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQwMTI3OTUsImV4cCI6MjA0OTU4ODc5NX0.HDr-eH9wQn1FqQeCW3dE1lXUG0xezCsGd0fxQlnAkkM",
    options: SupabaseClientOptions(global: .init(headers: ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3d3h5cHBna3JlcGdhbHFyeHB3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczNDAxMjc5NSwiZXhwIjoyMDQ5NTg4Nzk1fQ.0cnmbtqdVnQVvf6aTtNGXqSSGUS3ahE8pwydq9zRy9w"]))
    
)

func uploadimage(img: UIImage, email: String) async{
    guard let imgData = img.jpegData(compressionQuality: 0.8)else {
        return
    }
    
    do{
        try await supabase.storage.from("Images").upload(path: "\(email).jpeg", file: imgData, options: FileOptions(cacheControl: "3600", contentType: "image/jpeg", upsert: true)
        )
    }catch{
        print("\(error)")
    }
}


func loadImage(from link: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: link) else {
        print("Invalid URL")
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: url) { data, res, err in
        if let err = err {
            print("Error loading image: \(err)")
            completion(nil)
            return
        }
        
        guard let data = data, let image = UIImage(data: data) else {
            print("Could not convert data into image")
            completion(nil)
            return
        }

        DispatchQueue.main.async {
            completion(image)
        }
    }.resume()
}

