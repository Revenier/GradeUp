//
//  HomePageView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI
import FirebaseFirestore

struct HomePageView: View {
    
    @Binding var navigationPath : NavigationPath
    @State private var isDataLoaded = false
    @State private var userData: User?
    @State private var remainingTime: String = "0d 0h 0m 0s"
    @State private var timer: Timer?
    @State private var avatar: UIImage?
    
    var uesrGrade: String {
        UserDefaults.standard.string(forKey: "Grade")!
    }
    var userEmail: String {
        UserDefaults.standard.string(forKey: "userEmail") ?? ""
    }
    
    func fetchUserData() {
        userData?.url = ""
        searchUserByEmail(email: userEmail) { result in
            switch result {
            case .success(let user):
                if let user = user {
                    if !user.expiredDate.isEmpty {
                        startCountdown(expiredDate: user.expiredDate)
                    }
                    self.userData = user
                    
                    
                    loadImage(from: userData!.url){image in
                        
                        if let urlimage = image{
                            avatar = urlimage
                        }
                        
                    }
                        

                    print("User data updated: \(user.name)")
                } else {
                    print("No user found with the email \(userEmail)")
                }
            case .failure(let error):
                print("Error occurred: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchAllData(for gradeName: String) {
        fetchSubjectData(for: gradeName) { subjects in
            
            let gradeData = Grade(name: gradeName, subjects: subjects)

            setSubject(subjectsData: subjects)
            setGrade(gradeData: Grade(name: gradeName, subjects: subjects))
            
            isDataLoaded = true
        }
    }
    
    func startCountdown(expiredDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let expirationDate = dateFormatter.date(from: expiredDate) {
            let currentDate = Date()
            
            if expirationDate <= currentDate {
                remainingTime = "0d 0h 0m 0s"
                addSubscription(email: userEmail, subscription: "", days: 0) { error in
                    if let error = error {
                        print("Failed to add subscription: \(error.localizedDescription)")
                    } else {
                        print("Set no subscription")
                    }
                }
                return
            }
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                updateRemainingTime(expirationDate: expirationDate)
            }
        }
    }


    func updateRemainingTime(expirationDate: Date) {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: expirationDate)
        
        if let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second {
            remainingTime = "\(day)d \(hour)h \(minute)m \(second)s"
        }
    }
    
     
    
        
    
    
    
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
            VStack(spacing : 0 ) {
                
                homeHeader(navigationPath: $navigationPath, userData: $userData, avatar: $avatar)
                
                userLastJourney(navigationPath: $navigationPath, userData: $userData, remainingTime: $remainingTime)
                
                Text("Categories")
                    .font(.system(size: 16))
                    .padding(.top,35)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                if isDataLoaded {
                    subjectGridView(navigationPath: $navigationPath, remainingTime: $remainingTime)
                } else {
                    Text("Loading categories...")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                }
                
                
                Spacer()
            }
            .padding(.horizontal, 37)
            .onAppear {
                fetchAllData(for: uesrGrade)
                fetchUserData()
                    
                
            }
            .onDisappear {
                isDataLoaded = false
            }
        }
    }
}

#Preview {
    HomePageView(navigationPath: .constant(NavigationPath()))
}

struct homeHeader : View {
    
    @Binding var navigationPath : NavigationPath
    @Binding var userData: User?
    @Binding var avatar : UIImage?
    
    
    var body : some View {
        HStack {
            VStack(spacing: 0) {
                Text("Hi, \(userData?.name ?? "")")
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                Text("Let's Start Learning")
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 48, alignment: .leading)
            
            Button(action: {
                navigationPath.append("Profile")
                
            }) {
                
                if let img = avatar {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 57, height: 57)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                        .padding(.vertical,32)
                }
                else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 57, height: 57)
                        .foregroundColor(.gray)
                        .padding(.vertical,32)
                }
                
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
        }
    }
    
}

struct userLastJourney : View {
    
    @Binding var navigationPath : NavigationPath
    @Binding var userData: User?
    @Binding var remainingTime: String
    
    var body : some View {
        VStack(spacing : 25){
            
            Text("Your Subscription")
                .font(.system(size: 14))
                .foregroundColor(Color(UIColor(named: "SecondaryTextColor")!))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.horizontal, 20)
           
            if remainingTime == "0d 0h 0m 0s" {
                Text("No Subscription")
                    .lineLimit(1)
                    .font(.system(size: 18))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 20)
            } else {
                Text(userData?.subscription.isEmpty ?? true ? "No Subscription" : "\(userData?.subscription ?? "")")
                    .lineLimit(1)
                    .font(.system(size: 18))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 20)
            }
            
            
            HStack(spacing: 0){
                
                VStack(spacing: 10){
                    Text("CountDown")
                        .lineLimit(1)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(remainingTime) 
                        .lineLimit(1)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                ButtonSecondary(iconPos: .right, title: "Choose", onClick: {
                    
                    navigationPath.append("Subscription")
                }, isEnabled: .constant(remainingTime == "0d 0h 0m 0s"),
                   titleSize: 10, width: 102, height: 27)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing,30)
            .padding(.leading, 20)
          
            
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity , maxHeight: 163)
        .background {
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 10.0,
                bottomLeading: 10.0,
                bottomTrailing: 10.0,
                topTrailing: 50.0),
                                   style: .continuous)
            .foregroundStyle(.white)
            .shadow(color: .gray, radius: 2, x: 0, y: 4)
        }
    }
}

struct subjectGridView : View{
    @Binding var navigationPath : NavigationPath
    @Binding var remainingTime: String
    
    //3 items per column
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let items = Array(1...subjectsTemp.count)
    let colorCount = subjectColor.count
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns, spacing: 20){
                ForEach(items, id: \.self){ subject in
                    SubjectPrimary(backgroundColor: subjectColor[subject-1 % colorCount], subjectTitle: subjectsTemp[subject-1].name, subjectLogo: Image(subjectsTemp[subject-1].name), subjectIndex:"\(subject-1)", remainingTime: $remainingTime ,navigationPath: $navigationPath)
                }
            }
        }
        .padding(.top, 20)
        
    }
}


